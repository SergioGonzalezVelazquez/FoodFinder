import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';
import 'package:app_ipo/model/pedido_model.dart';

final String phpRestaurantes = "restaurantes.php";
final String phpOpiniones = "opiniones.php";
final String phpProductos = "productos.php";
final String phpLogin = "loginNuevo.php";
final String phpPedidos = "pedidos.php";
final String phpSignUp = "signup.php";

class ConectorBBDD {
  static String endpointBBDD = "https://ipo-flutter.000webhostapp.com/";

  static Widget errorServidor() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              width: 90.0,
              height: 90.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('images/antenna.png')))),
          SizedBox(height: 16),
          Text(
            'Error de conexión',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Future<User> login(String email, String pass) async {
    final response = await http.post(endpointBBDD + phpLogin, body: {
      "email": email,
      "password": pass,
    });
    try {
      var dataUser = json.decode(response.body);
      if (dataUser.length == 0) {
        return null;
      } else {
        User user = new User.fromJson(dataUser[0]);
        user.pedidos = await ConectorBBDD.pedidos(user.id);
        return user;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<User> loginGoogle() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    if (firebaseUser != null) {
      //Si el usuario de Google existe, comprobamos si está registrado en nuestra BBDD
      final response = await http.post(endpointBBDD + phpLogin, body: {
        "email": firebaseUser.email,
      });
      try {
        var dataUser = json.decode(response.body);
        if (dataUser.length == 0) {
          //No está registrado, lo registramos
          User nuevoUser = new User(
              firebaseUser.displayName, firebaseUser.email,
              fotoPerfil: firebaseUser.photoUrl,
              telefono: firebaseUser.phoneNumber);
          ConectorBBDD.signup(nuevoUser);
          return nuevoUser;
        } else {
          User user = new User.fromJson(dataUser[0]);
          user.pedidos = await ConectorBBDD.pedidos(user.id);
          return user;
        }
      } catch (e) {
        return new User(firebaseUser.displayName, firebaseUser.email,
            fotoPerfil: firebaseUser.photoUrl,
            telefono: firebaseUser.phoneNumber);
      }
    } else {
      return null;
    }
  }

  static Future<bool> signup(User usuario) async {
    final response = await http.post(endpointBBDD + phpSignUp, body: {
      "email": usuario.email,
      "password": usuario.password,
      "nombre": usuario.nombre,
      "fotoPerfil": usuario.fotoPerfil,
      "telefono": usuario.telefono
    });

    try {
      var jsonData = json.decode(response.body);
      if (jsonData['code'] == '1') {
        //success code
        return true;
      } else {
        //error code
        return false;
      }
    } catch (e) {
      return false;
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

  static Future<List<Pedido>> pedidos(int idUsuario) async {
    final response = await http.post(endpointBBDD + phpPedidos, body: {
      "idCliente": idUsuario.toString(),
    });
    List pedidos = json.decode(response.body);
    return pedidos.map((i) => new Pedido.fromJson(i)).toList();
  }
}
