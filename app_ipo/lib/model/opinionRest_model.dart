class ModeloOpinionRestaurante {
  String _nombreUser;
  int _valoracion;
  String _comentario;
  String _fecha;

  ModeloOpinionRestaurante(
      {String nombreUser, String fecha, String comentario, int valoracion}) {
    this._nombreUser = nombreUser;
    this._comentario = comentario;
    this._fecha = fecha;
    this._valoracion = valoracion;
  }

  String get nombreUser => _nombreUser;
  String get fecha => _fecha;
  String get comentario => _comentario;
  int get valoracion => _valoracion;
}
