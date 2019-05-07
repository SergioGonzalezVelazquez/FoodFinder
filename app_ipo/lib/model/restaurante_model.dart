class ModeloRestaurante {
  String _nombre;
  String _imagen;
  String _categoria;
  int _valoracion; //Valores entre 0 y 5
  int _numValoraciones;
  String _distancia;
  double _pedidoMinimo;
  double _envio;
  double _descuento;

  //Listado de productos

  ModeloRestaurante(
      {String nombre,
      String imagen,
      String categoria,
      int valoracion,
      int numValoraciones,
      String distancia,
      double pedidoMinimo,
      double envio,
      double descuento}) {
    this._nombre = nombre;
    this._imagen = imagen;
    this._categoria = categoria;
    this._valoracion = valoracion;
    this._numValoraciones = numValoraciones;
    this._pedidoMinimo = pedidoMinimo;
    this._distancia = distancia;
    this._envio = envio;
    this._descuento = descuento;
  }

  String get nombre => _nombre;
  String get imagen => _imagen;
  String get categoria => _categoria;
  int get valoracion => _valoracion;
  String get numValoraciones => _numValoraciones.toString();
  String get distancia => _distancia;
  String get pedidoMinimo => _pedidoMinimo.toStringAsFixed(2);
  String get envio => _envio.toStringAsFixed(2);
  double get descuento => _descuento;
}
