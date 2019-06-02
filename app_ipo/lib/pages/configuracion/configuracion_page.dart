import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/pages/configuracion/info_cuenta_page.dart';
import 'package:app_ipo/pages/configuracion/notificaciones_page.dart';
import 'package:app_ipo/pages/configuracion/credito_cuenta_page.dart';
import 'package:app_ipo/pages/configuracion/direcciones_page.dart';

class SettingsPage extends StatelessWidget {
//Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/configuracion";
  User user;
  SettingsPage(this.user);

  Widget _infoVersion(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(color: Colors.grey),
      child: Center(child: Text('versión 6.9.1.77645')),
    );
  }

  Widget _configuracionPage(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 25, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Detalles de la cuenta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 20),
            _itemConfiguracion(
                context, Icons.person, 'Información de la cuenta', 0),
            _itemConfiguracion(
                context, Icons.card_giftcard, 'Crédito de la cuenta', 1),
            _itemConfiguracion(
                context, Icons.location_on, 'Direcciones de reparto', 2),
            _itemConfiguracion(context, Icons.notifications,
                'Preferencias de notificación', 3),
            SizedBox(height: 40),
            Text(
              'General',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 20),
            _itemConfiguracion(
                context, Icons.format_align_left, 'Condiciones legales', 4),
          ],
        ));
  }

  _onItemTap(BuildContext context, int index) {
    Route ruta;

    switch (index) {
      case 0: //Información de la cuenta
        ruta = new MaterialPageRoute(
            builder: (context) => new InfoCuentaPage(user));
        break;
      case 1: //Crédito de la cuenta
        ruta = new MaterialPageRoute(
            builder: (context) => new CreditoCuentaPage());
        break;
      case 2: //Direcciones de reparto
        ruta = new MaterialPageRoute(
            builder: (context) => new DireccionesPage(user));
        break;
      case 3: //Preferencias de notificación
        ruta = new MaterialPageRoute(
            builder: (context) => new NotificacionesPage());
        break;
      case 4: //Condiciones legales
        ruta = new MaterialPageRoute(
            builder: (context) => new InfoCuentaPage(user));
        break;
    }
    Navigator.push(context, ruta);
  }

  Widget _itemConfiguracion(
      BuildContext context, IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        _onItemTap(context, index);
      },
      child: Container(
        width: double.infinity,
        //height: MediaQuery.of(context).size.height / 15,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 30, color: Theme.of(context).primaryColor),
                SizedBox(width: 30),
                Text(label),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Configuración'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: _configuracionPage(context),
      bottomNavigationBar: _infoVersion(context),
    );
  }
}
