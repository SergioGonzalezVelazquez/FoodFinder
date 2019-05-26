import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_ipo/model/user_model.dart';
/* 
 * Clase responsable de abstraer la autenticación
 * y recuperación de información del usuario
 */

class UserRepository {
   static final String BBDD = "https://ipo-flutter.000webhostapp.com/login.php";

  static Future<User> login(String email, String pass) async {
    final response = await http.post(BBDD, body: {
      "email": email,
      "password": pass,
    });
    var dataUser = json.decode(response.body);

    if (dataUser.length == 0) {
      return null;
    } else {
      return new User.fromJson(dataUser);
    }
  }
}
