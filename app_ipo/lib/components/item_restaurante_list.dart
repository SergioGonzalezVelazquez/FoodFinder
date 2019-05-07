import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/star_rating.dart';

class ItemRestauranteList extends StatelessWidget {
  final ModeloRestaurante _restaurante;

  ItemRestauranteList(this._restaurante);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Divider(
          height: 30.0,
        ),
        new ListTile(
          //Logo del restaurante y distancia (izq)
          leading: Container(
            width: MediaQuery.of(context).size.width / 8,
            // height: MediaQuery.of(context).size.width / 5,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 9),
                  height: MediaQuery.of(context).size.width / 8,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(_restaurante.imagen))),
                ),
                Padding(
                    // alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 15.0,
                        ),
                        Text(
                          _restaurante.distancia + ' km',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //Nombre del restaurante
          title: new Text(
            _restaurante.nombre,
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),

          //Valoración e información adicional
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  StarDisplayWidget(
                    value: _restaurante.valoracion,
                    filledStar: Icon(Icons.star, color: Colors.red, size: 13.5),
                    unfilledStar:
                        Icon(Icons.star, color: Colors.grey, size: 13.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('('+_restaurante.numValoraciones+')'),
                  )
                ],
              ),
              Text(
                _restaurante.categoria,
              ),
              new Row(
                children: <Widget>[
                  Text('Pedido mínimo: €' + _restaurante.pedidoMinimo),
                  Text(
                    'A domicilio: €' + _restaurante.envio,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Has pulsado:' + _restaurante.nombre);
          },
        )
      ],
    );
  }
}
