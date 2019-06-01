import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/pages/my_drawer.dart';


class FavoritosPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/favoritos";
  User user;

  FavoritosPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Favoritos'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      drawer: MyDrawer(user, index: MyDrawer.indexPerfil),
      body: new Container(
        child: new Center(
          child: new Text("Widget de favoritos..."),
        ),
      ),
    );
  }
}
