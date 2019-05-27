import 'package:flutter/material.dart';
import 'package:app_ipo/pages/home_page.dart';
import 'package:app_ipo/pages/login_page.dart';
import 'package:app_ipo/pages/singup_page.dart';
import 'package:app_ipo/pages/configuracion_page.dart';
import 'package:app_ipo/pages/restaurantes_page.dart';
import 'package:app_ipo/pages/pedidos_page.dart';
import 'package:app_ipo/pages/perfil_page.dart';
import 'package:app_ipo/pages/order_page.dart';
import 'package:app_ipo/pages/cart_page.dart';

/**
 * Diccionario (Map) con los nombres de las rutas como "claves" y 
 * elementos WidgetBuilder como "valor". En la definición de cada 
 * WidgetBuilder se especfica el widget a renderizar asociado a esa
 * ruta en particular. Además, se han usado variables estáticas para
 * guardar las cadenas de las rutas y mantenerlas encapsuladas en las
 * clases que representan. 
 */

final myRoutes = {
  '/': (BuildContext context) => LoginPage(),
  SignUpPage.nombreRuta: (BuildContext context) => SignUpPage(),
  LoginPage.nombreRuta: (BuildContext context) => LoginPage(),
  HomePage.nombreRuta: (BuildContext context) => HomePage(),
  SettingsPage.nombreRuta: (BuildContext context) => SettingsPage(),
  RestaurantesPage.nombreRuta: (BuildContext context) => RestaurantesPage(),
  PedidosPage.nombreRuta: (BuildContext context) => PedidosPage(),
  PerfilPage.nombreRuta: (BuildContext context) => PerfilPage(),
  OrderPage.nombreRuta: (BuildContext context) => OrderPage(),
  CartPage.nombreRuta: (BuildContext context) => CartPage(),
};
