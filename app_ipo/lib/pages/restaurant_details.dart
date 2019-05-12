import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/star_rating.dart';

//tabs imports
import 'package:app_ipo/pages/tabs_restaurant_details/info_restaurante.dart';
import 'package:app_ipo/pages/tabs_restaurant_details/menus.dart';
import 'package:app_ipo/pages/tabs_restaurant_details/opiniones.dart';

class RestaurantDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final ModeloRestaurante restaurante;

  RestaurantDetailsPage({this.restaurante});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantDetailsState();
  }
}

class _RestaurantDetailsState extends State<RestaurantDetailsPage>
    with SingleTickerProviderStateMixin {
  @override
  TabController _controladorTabs;

  void initState() {
    super.initState();
    _controladorTabs = new TabController(vsync: this, length: 3);
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(title: new Text(widget.restaurante.nombre)),
      body: new Container(
        child: new Column(
          children: <Widget>[
            //Barra superior con imagen de fondo e informacion del restaurante
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.modulate),
                      image: AssetImage(widget.restaurante.imagenFondo),
                      fit: BoxFit.cover)),
              child: new Row(children: <Widget>[
                //Información sobre la imagen del fondo

                Container(
                  //Logo del restaurante
                  margin: const EdgeInsets.only(left: 25),
                  height: MediaQuery.of(context).size.width / 5,
                  width: MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: new Border.all(color: Colors.white),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(widget.restaurante.imagenLogo))),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Column(
                      //Valoración y categoría
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        new Text(
                          widget.restaurante.nombre,
                          style: new TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.restaurante.categoria,
                                style: new TextStyle(color: Colors.white)),
                            new Row(
                              children: <Widget>[
                                StarDisplayWidget(
                                  value: widget.restaurante.valoracion,
                                  filledStar: Icon(Icons.star,
                                      color: Colors.white, size: 13.5),
                                  unfilledStar: Icon(Icons.star,
                                      color: Colors.grey, size: 13.5),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: new Text(
                                      '(' +
                                          widget.restaurante.numValoraciones +
                                          ')',
                                      style:
                                          new TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ))
              ]),
            ),
            Container(
              child: TabBar(
                tabs: <Widget>[
                  new Tab(
                    text: "Menú",
                  ),
                  new Tab(
                    text: "Opiniones",
                  ),
                  new Tab(
                    text: "Información",
                  )
                ],
                controller: _controladorTabs,
              ),
            ),
            Expanded(
              child: new TabBarView(
                controller: _controladorTabs,
                children: <Widget>[
                  new RestaurantMenus(productos: widget.restaurante.productos),
                  new RestaurantOpiniones(opiniones: widget.restaurante.opiniones),
                  new RestaurantInfo(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
