import 'package:flutter/material.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/components/item_pedido_list.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/components/listview_pedidos.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/my_drawer.dart';

//bbdd
import 'package:app_ipo/data/gestorBBDD.dart';

class PedidosPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/pedidos";
  User user;

  PedidosPage(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    _fetchPedidos();
  }

  void _fetchPedidos() async {
    setState(() {
      isLoading = true;
    });

    listPedidosGlobal = await ConectorBBDD.pedidos(widget.user.id);
    if (listPedidosGlobal != null) {
      widget.user.pedidos = listPedidosGlobal;
      _clasificarPedidos();
    }

    setState(() {
      isLoading = false;
    });
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

  Widget _listadoPedidos() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listPedidosGlobal.length,
          itemBuilder: (context, int item) =>
              new ItemPedidoList(listPedidosGlobal[item])),
    );
  }

  Widget _vistaPedidos() {
    //Se ha producido un error de conexión con el servidor
    if (listPedidosGlobal == null) {
      print('Error con el servidor');
      return ConectorBBDD.errorServidor();
    } else {
      return new TabBarView(controller: _tabController, children: <Widget>[
        PedidosList(listPedidosProgreso),
        PedidosList(listPedidosHistorial),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
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
        ),
        drawer: MyDrawer(widget.user, index: MyDrawer.indexPedidos),
        body: (isLoading)
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              )
            : _vistaPedidos());
  }
}
