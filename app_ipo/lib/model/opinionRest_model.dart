class OpinionRestaurante {
  int _id;
  String _nombreUser;
  int _valoracion;
  String _comentario;
  String _fecha;

  OpinionRestaurante(
      {int id, String nombreUser, String fecha, String comentario, int valoracion}) {
        this._id = id;
    this._nombreUser = nombreUser;
    this._comentario = comentario;
    this._fecha = fecha;
    this._valoracion = valoracion;
  }

  factory OpinionRestaurante.fromJson(Map<String, dynamic> jsonData) {
    return OpinionRestaurante(
      id: int.parse(jsonData['id']),
      nombreUser: jsonData['nombreUser'],
      comentario: jsonData['comentario'],
      fecha: jsonData['fecha'],
      valoracion: int.parse(jsonData['valoracion']),
    );
  }
  int get id => _id;
  String get nombreUser => _nombreUser;
  String get fecha => _fecha;
  String get comentario => _comentario;
  int get valoracion => _valoracion;
}
