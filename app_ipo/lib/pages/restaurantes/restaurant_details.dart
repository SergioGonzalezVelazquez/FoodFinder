import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/opinionRest_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/components/star_rating.dart';
import 'package:app_ipo/pages/cart_page.dart';

//tabs imports
import 'package:app_ipo/pages/restaurantes/tabs_restaurant_details/info_restaurante.dart';
import 'package:app_ipo/pages/restaurantes/tabs_restaurant_details/productos_restaurante.dart';
import 'package:app_ipo/pages/restaurantes/tabs_restaurant_details/opiniones.dart';

//bbdd
import 'package:app_ipo/data/gestorBBDD.dart';

class RestaurantDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final Restaurante restaurante;

  RestaurantDetailsPage({this.restaurante});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantDetailsState();
  }
}

class _RestaurantDetailsState extends State<RestaurantDetailsPage>
    with SingleTickerProviderStateMixin{
  @override
  TabController _controladorTabs;
  bool isLoadingOpinions = false;
  bool isLoadingProducts = false;
  Pedido _pedidoActual;

 
  void _fetchOpiniones() async {
    setState(() {
      isLoadingOpinions = true;
    });

    List<OpinionRestaurante> opiniones =
        await ConectorBBDD.opiniones(widget.restaurante.id);
    widget.restaurante.opiniones = opiniones;

    setState(() {
      isLoadingOpinions = false;
    });
  }

  void _fetchProductos() async {
    setState(() {
      isLoadingProducts = true;
    });

    List<Producto> productos =
        await ConectorBBDD.productos(widget.restaurante.id);
    widget.restaurante.productos = productos;

    setState(() {
      isLoadingProducts = false;
    });
  }

  void initState() {
    super.initState();

    _controladorTabs = new TabController(vsync: this, length: 3);
    _fetchOpiniones();
    _fetchProductos();
    print(ConectorBBDD.endpointBBDD +
                              widget.restaurante.imagenLogo);

    _pedidoActual = new Pedido(
        envio: widget.restaurante.envio,
        descuento: widget.restaurante.descuento);
  }

  Widget _buildAppBar(BuildContext context, Pedido pedido) {
    return new AppBar(
      title: new Text(widget.restaurante.nombre),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Route ruta = new MaterialPageRoute(
                builder: (context) => new CartPage(
                      pedidoActual: _pedidoActual,
                    ));
            Navigator.push(context, ruta);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    new Icon(
                      Icons.shopping_basket,
                      color: Theme.of(context).bottomAppBarColor,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    new Text(
                      (_pedidoActual.numProductos() == 0)
                          ? '0'
                          : (_pedidoActual.numProductos().toString() +
                              ' | €' +
                              _pedidoActual.total.toStringAsFixed(2)),
                      style: TextStyle(
                          color: Theme.of(context).bottomAppBarColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRestaurante(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.modulate),
              image: NetworkImage(ConectorBBDD.endpointBBDD +
                              widget.restaurante.imagenFondo),
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
                  image: NetworkImage(ConectorBBDD.endpointBBDD +
                              widget.restaurante.imagenLogo))),
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
                          filledStar:
                              Icon(Icons.star, color: Colors.white, size: 13.5),
                          unfilledStar:
                              Icon(Icons.star, color: Colors.grey, size: 13.5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: new Text(
                              '(' +
                                  widget.restaurante.numValoraciones
                                      .toString() +
                                  ')',
                              style: new TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ))
      ]),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Container(
      child: TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        tabs: <Widget>[
          new Tab(
            text: "Menús",
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
    );
  }

  Widget _tabBarView(BuildContext context) {
    return Expanded(
      child: new TabBarView(
        controller: _controladorTabs,
        children: <Widget>[
          isLoadingProducts
              ? new Center(
                  child: CircularProgressIndicator(),
                )
              : new RestaurantMenus(productos: widget.restaurante.productos, pedidoActual: _pedidoActual,),
          isLoadingOpinions
              ? new Center(
                  child: CircularProgressIndicator(),
                )
              : new RestaurantOpiniones(
                  opiniones: widget.restaurante.opiniones),
          new RestaurantInfo(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(context, _pedidoActual),
      body: new Container(
        child: new Column(
          children: <Widget>[
            //Barra superior con imagen de fondo e informacion del restaurante
            _infoRestaurante(context),
            _tabBar(context),
            _tabBarView(context),
          ],
        ),
      ),
    );
  }
}
