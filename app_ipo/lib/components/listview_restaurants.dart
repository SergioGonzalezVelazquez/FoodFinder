import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/item_restaurante_list.dart';
import 'package:app_ipo/model/user_model.dart';

class RestaurantsList extends StatefulWidget {
  final List<Restaurante> _listRestaurantes;
  final User _user;

  RestaurantsList(this._listRestaurantes, this._user);
  @override
  State<StatefulWidget> createState() {
    return _RestaurantsListState();
  }
}

class _RestaurantsListState extends State<RestaurantsList> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
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
                widget._listRestaurantes.length.toString() + ' restaurantes'),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget._listRestaurantes.length,
                itemBuilder: (context, int item) =>
                    new ItemRestauranteList(widget._listRestaurantes[item], widget._user)))
      ],
    );
  }
}
