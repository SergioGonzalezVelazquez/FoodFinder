import 'package:flutter/material.dart';
import 'package:app_ipo/model/opinionRest_model.dart';
import 'package:app_ipo/components/item_opinion_list.dart';

class RestaurantOpiniones extends StatefulWidget {
  final List< ModeloOpinionRestaurante> opiniones;

  RestaurantOpiniones({this.opiniones});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantOpinionesState();
  }
}

class _RestaurantOpinionesState extends State<RestaurantOpiniones> {
  @override
  Widget build(BuildContext context) {
    if (widget.opiniones != null) {
// TODO: implement build
      return new ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.opiniones.length,
          itemBuilder: (context, int item) =>
              new ItemOpinionList(widget.opiniones[item]));
    } else {
      return new Container(
        child: new Center(
          child: new Text("No hay comentarios disponibles"),
        ),
      );
    }
  }
}
