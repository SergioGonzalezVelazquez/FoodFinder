import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
//Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/configuracion";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Configuración"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Widget de configuración..."),
        ),
      ),
    );
  }
}
