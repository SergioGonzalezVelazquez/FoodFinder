import 'package:flutter/material.dart';
import 'package:app_ipo/components/item_pedido_list.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/my_drawer.dart';

//bbdd
import 'package:app_ipo/data/gestorBBDD.dart';

class PedidosPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/pedidos";
  final User _user;

  PedidosPage(this._user);

  @override
  State<StatefulWidget> createState() {
    return _PedidosPageState();
  }
}

class _PedidosPageState extends State<PedidosPage>
    with SingleTickerProviderStateMixin {
  //Listado de todos los restaurantes recuperados del servidor
  TabController _tabController;
  bool isLoading = true;
  List<Pedido> listPedidosGlobal;
  List<Pedido> listPedidosHistorial;
  List<Pedido> listPedidosProgreso;

  @override
  void initState() {
    _tabController = new TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    isLoading = true;
    listPedidosGlobal = widget._user.pedidos;
    _clasificarPedidos();
    isLoading = false;

    //_fetchPedidos();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _clasificarPedidos() {
    /*A partir del listado global de pedidos, separamos pedidos en progreso
    y pedidos completados o cancelados para mostrarlos en pestañas diferentes */
    listPedidosHistorial = new List<Pedido>();
    listPedidosProgreso = new List<Pedido>();
    listPedidosGlobal.forEach((pedido) => (pedido.estado == 1)
        ? listPedidosProgreso.add(pedido)
        : listPedidosHistorial.add(pedido));
  }

  Widget _listadoPedidos(BuildContext context, List<Pedido> pedidos,
      String label, String descripcion) {
    return (pedidos.length == 0)
        ? _sinPedidos(context, label, descripcion)
        : (new Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: pedidos.length,
                  itemBuilder: (context, int item) =>
                      new ItemPedidoList(pedidos[item], widget._user)),
            )
          ]));
  }

  Widget _sinPedidos(BuildContext context, String label, String descripcion) {
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

  Widget _vistaPedidos(BuildContext context) {
    //Se ha producido un error de conexión con el servidor
    if (listPedidosGlobal == null) {
      print('Error con el servidor');
      return ConectorBBDD.errorServidor();
    } else {
      return new TabBarView(controller: _tabController, children: <Widget>[
        _listadoPedidos(
            context,
            listPedidosProgreso,
            'Haz un pedido ahora mismo',
            'Cuando tenga un pedido en curso aparecerá aquí para que puedas visualizar su estado y/o cancelarlo '),
        _listadoPedidos(context, listPedidosHistorial, 'Haz tu primer pedido',
            'Cuando hayas hecho un pedido te aparecerá aquí toda la información del mismo para que puedas repetirlo en futuras ocasiones'),
      ]);
    }
  }

  Widget _builAppBar() {
    return new AppBar(
      //elevation: 0.0, //Quitar sombra de la appBar
      title: new Text('Mis pedidos'),
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
          new Tab(text: 'En progreso'),
          new Tab(text: 'Historial'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _builAppBar(),
        drawer: MyDrawer(widget._user, index: MyDrawer.indexPedidos),
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              )
            : _vistaPedidos(context));
  }
}
