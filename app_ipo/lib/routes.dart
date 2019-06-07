import 'package:flutter/material.dart';
import 'package:app_ipo/pages/login_page.dart';
import 'package:app_ipo/pages/singup_page.dart';

/// Diccionario (Map) con los nombres de las rutas como "claves" y 
/// elementos WidgetBuilder como "valor". En la definición de cada 
/// WidgetBuilder se especfica el widget a renderizar asociado a esa
/// ruta en particular. Además, se han usado variables estáticas para
/// guardar las cadenas de las rutas y mantenerlas encapsuladas en las
/// clases que representan. 

final myRoutes = {
  '/': (BuildContext context) => LoginPage(),
  SignUpPage.nombreRuta: (BuildContext context) => SignUpPage(),
  LoginPage.nombreRuta: (BuildContext context) => LoginPage(),

};
