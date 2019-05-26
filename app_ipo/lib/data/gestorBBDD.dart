import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';

final String endpointBBDD = "https://ipo-flutter.000webhostapp.com/";
final String phpRestaurantes = "restaurant.php";
final String phpLogin = "login.php";

class conectorBBDD {
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

  static Future<List<ModeloRestaurante>> restaurantes() async {
    
    final response = await http.get(endpointBBDD + phpRestaurantes);

    List restaurantes = json.decode(response.body);
    print(restaurantes);

    return restaurantes.map((i) => new ModeloRestaurante.fromJson(i)).toList();
  }
}
