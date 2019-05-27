class ModeloProducto {
  int _id;
  String _nombre;
  String _imagen;
  String _descripcion;
  double _precio;

  ModeloProducto(
      {int id,
      String nombre,
      String imagen,
      String descripcion,
      double precio}) {
    this._id = id;
    this._nombre = nombre;
    this._imagen = imagen;
    this._descripcion = descripcion;
    this._precio = precio;
  }

  factory ModeloProducto.fromJson(Map<String, dynamic> jsonData) {
    return ModeloProducto(
      id: int.parse(jsonData['id']),
      nombre: jsonData['nombre'],
      imagen: jsonData['imagen'],
      descripcion: jsonData['descripcion'],
      precio: double.parse(jsonData['precio']),
    );
  }

  String get nombre => _nombre;
  String get imagen => _imagen;
  String get descripcion => _descripcion;
  double get precio => _precio;
}
