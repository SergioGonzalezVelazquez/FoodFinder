import 'package:flutter/material.dart';
import 'package:app_ipo/pages/restaurantes_page.dart';
import 'package:app_ipo/pages/pedidos_page.dart';


class HomePage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/home";
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListView _listaMenu;

/**
 * Función que devuelve el widget que se tiene
 * que mostrar en la pantalla dado un valor 
 * seleccionado.
 */

  int _selectDrawerItem = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new RestaurantesPage(); //Restaurantes
      case 1:
        return new PedidosPage(); //Pedidos
    }
  }

  _onSelectedItem(int pos) {
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  ListTile _construirItem(
      BuildContext context, IconData iconData, String texto, String ruta,
      {int pos}) {
    return new ListTile(
        leading: new Icon(iconData),
        title: new Text(texto),
        selected: (pos == _selectDrawerItem),
        onTap: () {
          if (pos != null) {
            Navigator.of(context).pop();
            _onSelectedItem(pos);
          } else {
            setState(() {
              Navigator.pushNamed(context, ruta);
            });
          }
        });
  }

  ListView _construirListView(BuildContext context) {
    return new ListView(children: <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text("Sergio González"),
        accountEmail: new Text("serglezv@gmail.com"),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: AssetImage('images/user.png'),
          backgroundColor: Colors.white,
          //child: new Text("S",style: new TextStyle( color: Colors.white)),
        ),
      ),
      _construirItem(context, Icons.restaurant, "Restaurantes", "/restaurantes",
          pos: 0),
      _construirItem(context, Icons.receipt, "Pedidos", "/pedidos", pos: 1),
      _construirItem(context, Icons.person, "Perfil", "/perfil"),
      new Divider(),
      _construirItem(
          context, Icons.settings, "Configuración", "/configuracion"),
      _construirItem(
        context,
        Icons.exit_to_app,
        "Desconectar",
        "/",
      ),
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
    return new Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Food Finder'),
        centerTitle: true,
      ),
      drawer: new Drawer(child: _construirListView(context)),
      body: _getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
