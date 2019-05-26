class User {
  String _id;
  String _nombre;
  String _email;
  String _password;

  User(this._id, this._nombre, this._email, this._password);

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(jsonData['id'], jsonData['nombre'], jsonData['email'],
        jsonData['password']);
  }

  String get id => _id;
  String get nombre => _nombre;
  String get email => _email;
  String get password => _password;
}
