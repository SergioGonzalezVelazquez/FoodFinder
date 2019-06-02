import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/components/observador_usuario.dart';

class Direccion {
  int _id;
  int _idUsuario;
  String _nombre;
  String _localidad;
  String _nombreVia;
  String _provincia;
  String _bloque;
  String _escalera;
  String _piso;
  int _codigoPostal;
  int _numero;

  Direccion(String nombre, String localidad, String nombreVia, String provincia,
      int numero, int codigoPostal,
      {int id, int idUsuario, String piso, String escalera, String bloque}) {
    this._id = id;
    this._idUsuario = idUsuario;
    this._nombre = nombre;
    this._localidad = localidad;
    this._nombreVia = nombreVia;
    this._provincia = provincia;
    this._codigoPostal = codigoPostal;
    this._numero = numero;
    this._bloque = bloque;
    this._piso = piso;
    this._escalera = escalera;
  }

  /*
  factory Direccion.fromJson(Map<String, dynamic> jsonData) {
    return Direccion(int.parse(jsonData['id']), jsonData['nombre'],
        jsonData['email'], jsonData['password']);
  }

  */

  int get id => _id;
  int get idUsuario => _idUsuario;
  int get numero => _numero;
  int get codigoPostal => _codigoPostal;
  String get nombre => _nombre;
  String get email => _localidad;
  String get password => _nombreVia;
  String get bloque => _bloque;
  String get provincia => _provincia;
  String get localidad => _localidad;
  String get escalera => _escalera;
  String get nombreVia => _nombreVia;

  set nombre(String nombre) => _nombre;
  set email(String email) => _localidad;
  set password(String password) => _nombreVia;
  set telefono(String telefono) => _provincia;
}
