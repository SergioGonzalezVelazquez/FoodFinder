import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/direcciones_model.dart';
import 'package:app_ipo/components/observador_usuario.dart';

class User {
  int _id;
  String _nombre;
  String _email;
  String _password;
  String _telefono;
  List<Direccion> _direcciones;
  List<Pedido> _historialPedidos;
  List<Restaurante> _restaurantesFavs;
  List<Producto> _platosFavs;

  List<ObservadorUsuario> _observadores;

  User(int id, String nombre, String email, String password,
      {String telefono,
      List<Direccion> direcciones,
      List<Pedido> historialPedido,
      List<Restaurante> restaurantesFavs,
      List<Producto> platosFavs}) {
    this._id = id;
    this._nombre = nombre;
    this._password = password;
    this._email = email;
    this._telefono = telefono;
    this._direcciones =
        (direcciones == null) ? new List<Direccion>() : direcciones;
    this._historialPedidos =
        (historialPedido == null) ? new List<Pedido>() : historialPedido;
    this._restaurantesFavs =
        (restaurantesFavs == null) ? new List<Restaurante>() : restaurantesFavs;
    this._platosFavs = (platosFavs == null) ? new List<Producto>() : platosFavs;
    this._observadores = new List<ObservadorUsuario>();
  }

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(int.parse(jsonData['id']), jsonData['nombre'],
        jsonData['email'], jsonData['password']);
  }

  void registrarObservador(ObservadorUsuario o) {
    _observadores.add(o);
  }

  void eliminarObservador(ObservadorUsuario o) {
    _observadores.remove(o);
  }

  int get id => _id;
  String get nombre => _nombre;
  String get email => _email;
  String get password => _password;
  String get telefono => _telefono;
  List<Direccion> get direcciones => _direcciones;
  List<Pedido> get pedidos => _historialPedidos;
  List<Producto> get platosFavs => _platosFavs;
  List<Restaurante> get restauranteFavs => _restaurantesFavs;

  set nombre(String nombre) => _nombre;
  set email(String email) => _email;
  set password(String password) => _password;
  set telefono(String telefono) => _telefono;
  set pedidos(List<Pedido> pedidos) => this._historialPedidos = pedidos;
  set platosFavs(List<Producto> platosFavs) => this._platosFavs = platosFavs;
  set restauranteFavs(List<Restaurante> restaurantesFavs) =>
      this._restaurantesFavs = restaurantesFavs;

  void updateUser(
      String nombre, String email, String password, String telefono) {
    _nombre = nombre;
    _email = email;
    _password = password;
    _telefono = telefono;
    _observadores.forEach((o) => o.updateUsuario());
  }
}
