import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';


class RestaurantInfo extends StatefulWidget {
  final Restaurante restaurante;

  RestaurantInfo({this.restaurante});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantInfoPage();
  }
}

class _RestaurantInfoPage extends State<RestaurantInfo> {
  @override
  Widget _ubicacionRestaurante(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        children: <Widget>[


          
        ],
      ),
    );
  }

  Widget _informacionRestaurante(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return new SingleChildScrollView(
      child: ConstrainedBox(
          constraints: new BoxConstraints(),
          child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                  top: 20),
              child: Column(
                children: <Widget>[
                  _ubicacionRestaurante(context),
                  SizedBox(height: 15),
                  _informacionRestaurante(context),
                  SizedBox(height: 15),
                ],
              ))),
    );
  }
}
