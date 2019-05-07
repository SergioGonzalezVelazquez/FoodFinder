import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/components/listview_foodCategories.dart';

class PerfilPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/perfil";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Perfil"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Widget de perfil..."),
        ),
      ),
    );
  }
}
