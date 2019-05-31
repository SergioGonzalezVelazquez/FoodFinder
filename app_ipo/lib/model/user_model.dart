import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';

class User {
  int _id;
  String _nombre;
  String _email;
  String _password;
  String _direccion;
  List<Pedido> _historialPedidos;
  List<Restaurante> _restaurantesFavs;
  List<Producto> _platosFavs;

  User(int id, String nombre, String email, String password,
      {String direccion,
      List<Pedido> historialPedido,
      List<Restaurante> restaurantesFavs,
      List<Producto> platosFavs}) {
    this._id = id;
    this._nombre = nombre;
    this._password = password;
    this._email = email;
    this._direccion = (direccion == null) ? direccion : '';
    this._historialPedidos =
        (historialPedido == null) ? new List<Pedido>() : historialPedido;
    this._restaurantesFavs =
        (restaurantesFavs == null) ? new List<Restaurante>() : restaurantesFavs;
    this._platosFavs = (platosFavs == null) ? new List<Producto>() : platosFavs;
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(int.parse(jsonData['id']), jsonData['nombre'],
        jsonData['email'], jsonData['password']);
  }

  int get id => _id;
  String get nombre => _nombre;
  String get email => _email;
  String get password => _password;
  String get direccion => _direccion;
  List<Pedido> get pedidos => _historialPedidos;
  List<Producto> get platosFavs => _platosFavs;
  List<Restaurante> get restauranteFavs => _restaurantesFavs;

  set pedidos(List<Pedido> pedidos) => this._historialPedidos = pedidos;
  set platosFavs(List<Producto> platosFavs) => this._platosFavs = platosFavs;
  set restauranteFavs(List<Restaurante> restaurantesFavs) => this._restaurantesFavs = restaurantesFavs;
}
