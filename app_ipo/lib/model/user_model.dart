import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';


class User {
  String _id;
  String _nombre;
  String _email;
  String _password;

  //Historial de pedido
  List<Pedido> historialPedidos;

  User(this._id, this._nombre, this._email, this._password, {this.historialPedidos});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(jsonData['id'], jsonData['nombre'], jsonData['email'],
        jsonData['password']);
  }

  String get id => _id;
  String get nombre => _nombre;
  String get email => _email;
  String get password => _password;
  List<Pedido> get pedidos => historialPedidos;
}
