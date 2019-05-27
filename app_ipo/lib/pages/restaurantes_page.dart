import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/components/listview_foodCategories.dart';
import 'package:app_ipo/components/listview_restaurants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RestaurantesPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/restaurantes";

  @override
  State<StatefulWidget> createState() => new _RestaurantesPageState();
}

class _RestaurantesPageState extends State<RestaurantesPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Panel superior con cuadro de búsqueda por localización
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.modulate),
                      image: AssetImage(
                        "images/customer-experience.jpg",
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pide lo que te pida el cuerpo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Comida a domicilio online cerca de ti',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        padding: EdgeInsets.only(
                            top: 4, left: 10, right: 4, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: new Row(
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                                decoration: InputDecoration.collapsed(
                                  hintText: "ej. Calle Alcalá, 48, Madrid",
                                ),
                              ),
                            ),
                            new FlatButton(
                              child: Text(
                                'Buscar',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () {
                                print("Has presionado el botón de búsqueda");
                                Fluttertoast.showToast(
                                    msg: "Funcionalidad no implementada... :(");
                              },
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('Tipos de cocinas populares'),
            ),
            //Scroll horizontal con categorías de restaurantes
            RestaurantTypeList(),
            //Listado de restaurantes según el filtro
            Expanded(
              child: RestaurantsList(),
            )
            //RestaurantsList(),
          ],
        ),
      ),
    );
  }
}
