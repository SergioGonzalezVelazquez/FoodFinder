import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/pages/my_drawer.dart';
import 'package:app_ipo/components/item_restaurante_favorito.dart';
import 'package:app_ipo/components/item_producto_favorito.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritosPage extends StatefulWidget {
  final User _user;

  FavoritosPage(this._user);

  @override
  State<StatefulWidget> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Restaurante> listRestaurantes;
  List<Producto> listProductos;

  @override
  void initState() {
    _tabController = new TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    listRestaurantes = widget._user.restauranteFavs;
    listProductos = widget._user.platosFavs;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget _builAppBar(BuildContext context) {
    return new AppBar(
      //elevation: 0.0, //Quitar sombra de la appBar
      title: new Text('Favoritos'),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      bottom: new TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: Theme.of(context).primaryColor,
        controller: _tabController,
        tabs: <Widget>[
          new Tab(text: 'Restaurantes'),
          new Tab(text: 'Platos'),
        ],
      ),
    );
  }

  Widget _sinFavoritos(BuildContext context, String label, String descripcion) {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              width: 90.0,
              height: 90.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('images/shopping_basket.png')))),
          SizedBox(height: 16),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            descripcion,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 40),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                "Buscar restaurantes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listadoRestaurantes(
      BuildContext context, String label, String descripcion) {
    return (listRestaurantes.length == 0)
        ? _sinFavoritos(context, label, descripcion)
        : (new Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listRestaurantes.length,
                  itemBuilder: (context, int item) =>
                      new ItemRestauranteFavorito(
                          listRestaurantes[item], widget._user)),
            )
          ]));
  }

  /*CAMBIAR CUANDO TENGAMOS EL ITEM DE PRODUCTO*/
  Widget _listadoProductos(
      BuildContext context, String label, String descripcion) {
    return (listProductos.length == 0)
        ? _sinFavoritos(context, label, descripcion)
        : new Column(children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: new StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: listProductos.length,
                  itemBuilder: (context, int item) => new ItemProductoFavorito(
                      listProductos[item]),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                ),
              ),
            )
          ]);
  }

  Widget _vistaFavoritos(BuildContext context) {
    //Se ha producido un error de conexión con el servidor
    if (listRestaurantes == null) {
      return ConectorBBDD.errorServidor();
    } else {
      return new TabBarView(controller: _tabController, children: <Widget>[
        _listadoRestaurantes(context, 'Añade restaurantes favoritos', ''),
        _listadoProductos(context, 'Añade platos favoritos', ''),
      ]);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _builAppBar(context),
        drawer: MyDrawer(widget._user, index: MyDrawer.indexPerfil),
        body: _vistaFavoritos(context));
  }
}
