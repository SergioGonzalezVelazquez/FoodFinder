import 'package:flutter/material.dart';
import 'package:app_ipo/model/opinionRest_model.dart';
import 'package:app_ipo/components/star_rating.dart';


class ItemOpinionList extends StatelessWidget {
  final OpinionRestaurante _opinion;

  ItemOpinionList(this._opinion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Divider(
          height: 15.0,
        ),
        new ListTile(
          //Nombre del usuario y fecha
          title: new Row(
            children: <Widget>[
              new Text(
                 _opinion.nombreUser,
            style: new TextStyle(fontWeight: FontWeight.bold),
              ),

              new Text(
                _opinion.fecha,
                style: new TextStyle(fontSize: 13.5),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          //Comentario
          subtitle: new Column(
            children: <Widget>[
              StarDisplayWidget(
                    value: _opinion.valoracion,
                    filledStar: Icon(Icons.star, color: Colors.red, size: 13.5),
                    unfilledStar:
                        Icon(Icons.star, color: Colors.grey, size: 13.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(_opinion.comentario),
                  )

            ],
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        )
      ],
    );
  }
}
