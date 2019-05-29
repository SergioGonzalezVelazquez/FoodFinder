import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';

class RestaurantsList extends StatefulWidget {
  List<Restaurante> listRestaurantes = List();

  RestaurantsList(this.listRestaurantes);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantsListState();
  }
}

class _RestaurantsListState extends State<RestaurantsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        //Barra con el número de resturantes encontrados
        Card(
          color: new Color(0xffeeeeee),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 25,
            padding: const EdgeInsets.only(left: 15, top: 4),
            child: new Text(
                widget.listRestaurantes.length.toString() + ' restaurantes'),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.listRestaurantes.length,
                itemBuilder: (context, int item) =>
                    new ItemRestauranteList(widget.listRestaurantes[item])))
      ],
    );
  }
}
