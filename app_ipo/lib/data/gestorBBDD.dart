import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';

final String phpRestaurantes = "restaurantes.php";
final String phpOpiniones = "opiniones.php";
final String phpProductos = "productos.php";
final String phpLogin = "login.php";

class ConectorBBDD {
  static String endpointBBDD = "https://ipo-flutter.000webhostapp.com/";


  static Future<User> login(String email, String pass) async {
    final response = await http.post(endpointBBDD + phpLogin, body: {
      "email": email,
      "password": pass,
    });

    var dataUser = json.decode(response.body);

    if (dataUser.length == 0) {
      return null;
    } else {
      return new User.fromJson(dataUser[0]);
    }
  }

  static Future<List<Restaurante>> restaurantes() async {
    final response = await http.get(endpointBBDD + phpRestaurantes);
    List restaurantes = json.decode(response.body);
    return restaurantes.map((i) => new Restaurante.fromJson(i)).toList();
  }

  static Future<List<Producto>> productos(int idRestaurante) async {
    final response = await http.post(endpointBBDD + phpProductos, body: {
      "idRestaurante": idRestaurante.toString(),
    });
    List productos = json.decode(response.body);
    return productos.map((i) => new Producto.fromJson(i)).toList();
  }

  static Future<List<OpinionRestaurante>> opiniones(int idRestaurante) async {
    final response = await http.post(endpointBBDD + phpOpiniones, body: {
      "idRestaurante": idRestaurante.toString(),
    });
    List opiniones = json.decode(response.body);
    return opiniones.map((i) => new OpinionRestaurante.fromJson(i)).toList();
  }

}
