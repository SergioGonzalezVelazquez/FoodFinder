import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/pages/restaurantes/restaurant_details.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/model/user_model.dart';

///Item del listado de restaurantes favoritos
///Se utliza en Favoritos -- Restaurantes
class ItemRestauranteFavorito extends StatelessWidget {
  final Restaurante _restaurante;
  final User _user;

  ItemRestauranteFavorito(this._restaurante, this._user);

  Widget _cardRestaurante(BuildContext context) {
    return InkWell(
      onTap: () {
        Route ruta = new MaterialPageRoute(
            builder: (context) =>
                new RestaurantDetailsPage(_restaurante, _user));
        Navigator.push(context, ruta);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(ConectorBBDD.endpointBBDD +
                              _restaurante.imagenFondo),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.black38,
                                child: Text(
                                  (_restaurante.distancia) + ' km',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.black38,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      _restaurante.valoracion.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.black38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '0 pedido(s)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Envío: ' +
                                  ((_restaurante.envio > 0)
                                      ? _restaurante.envio.toStringAsFixed(2) +
                                          '€'
                                      : 'Gratis'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      _restaurante.nombre,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      _restaurante.categoria,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width / 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                    border:
                        new Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(const Radius.circular(60.0)),
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(ConectorBBDD.endpointBBDD +
                            _restaurante.imagenLogo))),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _cardRestaurante(context),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
