import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';

class Restaurante {
  int _id;
  String _nombre;
  String _imagenLogo;
  String _imagenFondo;
  String _categoria;
  int _valoracion; //Valores entre 0 y 5
  int _numValoraciones;
  String _distancia;
  double _pedidoMinimo;
  double _envio;
  double _descuento;

  //Listado de productos
  List<Producto> _productos = new List<Producto>();

  //Listado de valoraciones
  List<OpinionRestaurante> _opiniones = new List<OpinionRestaurante>();

  Restaurante(
      {int id,
      String nombre,
      String imagenLogo,
      String imagenFondo,
      String categoria,
      int valoracion,
      int numValoraciones,
      String distancia,
      double pedidoMinimo,
      double envio,
      double descuento,
      List<Producto> productos,
      List<OpinionRestaurante> opiniones}) {
    this._id = id;
    this._nombre = nombre;
    this._imagenLogo = imagenLogo;
    this._imagenFondo = imagenFondo;
    this._categoria = categoria;
    this._valoracion = valoracion;
    this._numValoraciones = numValoraciones;
    this._pedidoMinimo = pedidoMinimo;
    this._distancia = distancia;
    this._envio = envio;
    this._descuento = descuento;
    this._opiniones = opiniones;
    this._productos = productos;
  }

  factory Restaurante.fromJson(Map<String, dynamic> jsonData) {
    return Restaurante(
      id: int.parse(jsonData['id']),
      nombre: jsonData['nombre'],
      imagenLogo: jsonData['imagenLogo'],
      imagenFondo: jsonData['imagenFondo'],
      categoria: jsonData['categoria'],
      valoracion: int.parse(jsonData['valoracion']),
      numValoraciones: int.parse(jsonData['numValoraciones']),
      distancia: jsonData['distancia'],
      pedidoMinimo: double.parse(jsonData['pedidoMinimo']),
      envio: double.parse(jsonData['envio']),
      descuento: double.parse(jsonData['descuento']),
    );
  }

  int get id => _id;
  String get nombre => _nombre;
  String get imagenLogo => _imagenLogo;
  String get imagenFondo => _imagenFondo;
  String get categoria => _categoria;
  int get valoracion => _valoracion;
  int get numValoraciones => _numValoraciones;
  String get distancia => _distancia;
  double get pedidoMinimo => _pedidoMinimo;
  double get envio => _envio;
  double get descuento => _descuento;
  List<Producto> get productos => _productos;
  List<OpinionRestaurante> get opiniones => _opiniones;

  set productos(List<Producto> products) => this._productos = products;

  set opiniones(List<OpinionRestaurante> opinions) =>
      this._opiniones = opinions;
}
