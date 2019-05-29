class Producto {
  int _id;
  String _nombre;
  String _imagen;
  String _descripcion;
  double _precio;

  Producto(
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

  factory Producto.fromJson(Map<String, dynamic> jsonData) {
    return Producto(
      id: int.parse(jsonData['id']),
      nombre: jsonData['nombre'],
      imagen: jsonData['imagen'],
      descripcion: jsonData['descripcion'],
      precio: double.parse(jsonData['precio']),
    );
  }

  int get id => _id;
  String get nombre => _nombre;
  String get imagen => _imagen;
  String get descripcion => _descripcion;
  double get precio => _precio;

  // Define that two Products are equal if their id are equal
  bool operator ==(dynamic other) {
    return (other.id == _id);
  }
}
