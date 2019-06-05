import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/star_rating.dart';
import 'package:app_ipo/pages/restaurantes/restaurant_details.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/model/user_model.dart';

class ItemRestauranteList extends StatelessWidget {
  final Restaurante _restaurante;
  final User _user;

  ItemRestauranteList(this._restaurante, this._user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Has pulsado:' + _restaurante.nombre);
        Route ruta = new MaterialPageRoute(
            builder: (context) =>
                new RestaurantDetailsPage(_restaurante, _user));
        Navigator.push(context, ruta);
      },
      child: new Column(
        children: <Widget>[
          new ListTile(
            //Logo del restaurante y distancia (izq)
            leading: Container(
              width: MediaQuery.of(context).size.width / 7,
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
                            image: NetworkImage(ConectorBBDD.endpointBBDD +
                                _restaurante.imagenLogo))),
                  ),
                  Padding(
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  _restaurante.nombre,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                Visibility(
                  visible: _restaurante.descuento > 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: new Text(
                      _restaurante.descuento.toStringAsFixed(0) + '% de dto.',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ),
                )
              ],
            ),

            //Valoración e información adicional
            subtitle: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    StarDisplayWidget(
                      value: _restaurante.valoracion,
                      filledStar:
                          Icon(Icons.star, color: Colors.red, size: 13.5),
                      unfilledStar:
                          Icon(Icons.star, color: Colors.grey, size: 13.5),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                          '(' + _restaurante.numValoraciones.toString() + ')'),
                    )
                  ],
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _restaurante.categoria,
                  ),
                ),
                new Row(
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Pedido mínimo: €' +
                          _restaurante.pedidoMinimo.toStringAsFixed(2)),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'A domicilio: €' +
                            _restaurante.envio.toStringAsFixed(2),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
            /*
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('Has pulsado:' + _restaurante.nombre);
              Route ruta = new MaterialPageRoute(
                  builder: (context) =>
                      new RestaurantDetailsPage(_restaurante, _user));
              Navigator.push(context, ruta);
            },
            */
          ),
          new Divider(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
