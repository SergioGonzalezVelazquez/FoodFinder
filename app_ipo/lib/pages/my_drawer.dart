import 'package:flutter/material.dart';
import 'package:app_ipo/pages/restaurantes/restaurantes_page.dart';
import 'package:app_ipo/pages/pedidos/pedidos_page.dart';
import 'package:app_ipo/pages/perfil_page.dart';
import 'package:app_ipo/pages/configuracion_page.dart';
import 'package:app_ipo/model/user_model.dart';

class MyDrawer extends StatefulWidget {
  static int indexRestaurantes = 0;
  static int indexPedidos = 1;
  static int indexPerfil = 2;
  static int indexConfiguracion = 3;
  static int indexDesconectar = 4;

  User user;
  int index;

  MyDrawer(this.user, {this.index});
  State<StatefulWidget> createState() => new _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectDrawerItem;

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _selectDrawerItem = widget.index;
    } else {
      _selectDrawerItem = 0;
    }
  }

  /* Función que devuelve el widget que se tiene que mostrar en la pantalla dado un valor seleccionado.*/
  Route _getRoute(int pos) {
    switch (pos) {
      case 0:
        return new MaterialPageRoute(
            builder: (context) => new RestaurantesPage(
                  widget.user,
                )); //Restaurantes
        break;
      case 1:
        return new MaterialPageRoute(
            builder: (context) => new PedidosPage(
                  widget.user,
                )); //Restaurantes//Pedidos
        break;
      case 2:
        return new MaterialPageRoute(
            builder: (context) => new PerfilPage(
                  widget.user,
                )); //Restaurantes
        break;
      case 3:
        return new MaterialPageRoute(
            builder: (context) => new SettingsPage(
                  widget.user,
                )); //Restaurantes
        break;
    }
  }

  ListTile _desconectarItem() {
    return new ListTile(
        leading: new Icon(Icons.exit_to_app),
        title: new Text('Desconectar'),
        onTap: () {
          setState(() {
           _selectDrawerItem = MyDrawer.indexDesconectar; 
          });
          Navigator.pushNamed(context, '/');
        });
  }

  ListTile _construirItem(BuildContext context, IconData iconData, String texto,
      {int pos}) {
    return new ListTile(
        leading: new Icon(iconData),
        title: new Text(texto),
        selected: (pos == _selectDrawerItem),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            Route ruta = _getRoute(pos);
            Navigator.push(context, ruta);
          });
        });
  }

  ListView _construirListView(BuildContext context) {
    return new ListView(children: <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text(widget.user.nombre),
        accountEmail: new Text(widget.user.email),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: AssetImage('images/user.png'),
          backgroundColor: Colors.white,
          //child: new Text("S",style: new TextStyle( color: Colors.white)),
        ),
      ),
      _construirItem(context, Icons.restaurant, "Restaurantes", pos: MyDrawer.indexRestaurantes),
      _construirItem(context, Icons.receipt, "Pedidos", pos: MyDrawer.indexPedidos),
      _construirItem(context, Icons.person, "Perfil", pos: MyDrawer.indexPerfil),
      new Divider(),
      _construirItem(context, Icons.settings, "Configuración", pos: MyDrawer.indexConfiguracion),
      _desconectarItem(),
      new AboutListTile(
        child: new Text("Acerca De"),
        applicationIcon: new Icon(Icons.info),
        icon: new Icon(Icons.info),
        applicationName: 'Food Finder',
        applicationVersion: 'v1.0',
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: _construirListView(context),
    );
  }
}
