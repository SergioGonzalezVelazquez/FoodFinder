class ModeloProducto {
  String _nombre;
  String _imagen;
  String _descripcion;
  double _precio;

  ModeloProducto(
      {String nombre,
      String imagen,
      String descripcion,
      double precio}) {
    this._nombre = nombre;
    this._imagen= imagen;
    this._descripcion = descripcion;
    this._precio = precio;
  }

  String get nombre => _nombre;
  String get imagen => _imagen;
  String get descripcion => _descripcion;
  double get precio => _precio;
}
