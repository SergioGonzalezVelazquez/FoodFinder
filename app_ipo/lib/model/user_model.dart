import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/direccion_model.dart';
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
    var listPlatosFavs = jsonData['platosFavs'] as List;
    List<Producto> platosFavs =
        listPlatosFavs.map((i) => Producto.fromJson(i)).toList();

    var listRestaurantesFavs = jsonData['restaurantesFavs'] as List;
    List<Restaurante> restaurantesFavs =
        listRestaurantesFavs.map((i) => Restaurante.fromJson(i)).toList();

    return User(int.parse(jsonData['id']), jsonData['nombre'],
        jsonData['email'], jsonData['password'],
        platosFavs: platosFavs, restaurantesFavs: restaurantesFavs);
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

  void insertarDireccion(Direccion d) {
    this._direcciones.add(d);
  }

  /*
  void insertarPlato(String p) {
    this._idPlatosFavs.add(p);
  }

  void insertarPedido(Pedido p) {
    this._historialPedidos.add(p);
  }

  void insertarRestauranteFav(String r) {
    this._idRestaurantesFavs.add(r);
  }

*/
  void updateUser(
      String nombre, String email, String password, String telefono) {
    _nombre = nombre;
    _email = email;
    _password = password;
    _telefono = telefono;
    _observadores.forEach((o) => o.updateUsuario());
  }
}
