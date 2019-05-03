import 'package:flutter/material.dart';

class PedidosPage extends StatelessWidget{
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/pedidos";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("Widget de PEDIDOS..."),
        ),
      ),
    );
  }
}