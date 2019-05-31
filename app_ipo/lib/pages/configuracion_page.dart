import 'package:flutter/material.dart';
import 'package:app_ipo/pages/my_drawer.dart';
import 'package:app_ipo/model/user_model.dart';

class SettingsPage extends StatelessWidget {
//Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/configuracion";
  User user;
  SettingsPage(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Configuración'),
        centerTitle: true,
      ),
      drawer: MyDrawer(user, index: MyDrawer.indexConfiguracion),
      body: new Container(
        child: new Center(
          child: new Text("Widget de configuración..."),
        ),
      ),
    );
  }
}
