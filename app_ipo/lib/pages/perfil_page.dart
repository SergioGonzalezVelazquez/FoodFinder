import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/pages/my_drawer.dart';

//my own imports
import 'package:app_ipo/components/listview_foodCategories.dart';

class PerfilPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/perfil";
  User user;

  PerfilPage(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Perfil page'),
        centerTitle: true,
      ),
      drawer: MyDrawer(user, index: MyDrawer.indexPerfil),
      body: new Container(
        child: new Center(
          child: new Text("Widget de perfil..."),
        ),
      ),
    );
  }
}
