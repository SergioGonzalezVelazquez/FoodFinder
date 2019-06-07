import 'package:flutter/material.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RestaurantInfo extends StatefulWidget {
  final Restaurante restaurante;

  RestaurantInfo(this.restaurante);

  @override
  State<StatefulWidget> createState() {
    return _RestaurantInfoPage();
  }
}

class _RestaurantInfoPage extends State<RestaurantInfo> {
  Widget _ubicacionRestaurante(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: "Funcionalidad no implementada");
      },
      child: new Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/map.png",
                      ),
                      fit: BoxFit.cover)),
            ),
            Text(
              'Calle del Puerto Canfranc 42',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Madrid, 28038',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informacionRestaurante() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Titulo y nombre del pedido
                Text(
                  'Información',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.restaurante.descripcion,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _aperturaRestaurante() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Titulo y nombre del pedido
                Text(
                  'Horario de apertura',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                itemApertura('Lunes', '12:00 - 23:59', 1, false),
                itemApertura('Martes', '12:00 - 23:59', 2, false),
                itemApertura('Miércoles', '12:00 - 23:59', 3, false),
                itemApertura('Jueves', '12:00 - 23:59', 4, false),
                itemApertura('Viernes', '12:00 - 23:59', 5, false),
                itemApertura('Sábado', '12:00 - 23:59', 6, true),
                itemApertura('Domingo', '12:00 - 23:59', 7, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemApertura(String dia, String horas, int index, bool selected) {
    return Container(
      color: index.isOdd ? Theme.of(context).buttonColor : Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
              child: Text(
            dia,
            style: TextStyle(
                fontWeight: selected ? FontWeight.bold : FontWeight.normal),
          )),
          Text(horas,
              style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal))
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: ConstrainedBox(
          constraints: new BoxConstraints(),
          child: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                  top: 20),
              child: Column(
                children: <Widget>[
                  _ubicacionRestaurante(context),
                  SizedBox(height: 15),
                  _informacionRestaurante(),
                  SizedBox(height: 15),
                  _aperturaRestaurante(),
                ],
              ))),
    );
  }
}
