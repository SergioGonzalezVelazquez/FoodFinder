import 'package:flutter/material.dart';
import 'package:app_ipo/model/categ_rest_mdel.dart';


class RestaurantesPage extends StatelessWidget{

  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/restaurantes";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        child: new Center(
          child: new Text("Widget RESTAURANTES..."),
        ),
      ),
    );
  }
}


