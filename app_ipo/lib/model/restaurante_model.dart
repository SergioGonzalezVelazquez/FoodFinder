import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';

class ModeloRestaurante {
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
  List<ModeloProducto> _productos = new List<ModeloProducto>();

  //Listado de valoraciones
  List<ModeloOpinionRestaurante> _opiniones =
      new List<ModeloOpinionRestaurante>();

  ModeloRestaurante(
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
      List<ModeloProducto> productos,
      List<ModeloOpinionRestaurante> opiniones}) {
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

  factory ModeloRestaurante.fromJson(Map<String, dynamic> jsonData) {
    return ModeloRestaurante(
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
  String get numValoraciones => _numValoraciones.toString();
  String get distancia => _distancia;
  String get pedidoMinimo => _pedidoMinimo.toStringAsFixed(2);
  String get envio => _envio.toStringAsFixed(2);
  double get descuento => _descuento;
  List<ModeloProducto> get productos => _productos;
  List<ModeloOpinionRestaurante> get opiniones => _opiniones;

  void set productos(List<ModeloProducto> products) =>
      this._productos = products;

  void set opiniones(List<ModeloOpinionRestaurante> opinions) =>
      this._opiniones = opinions;
}
