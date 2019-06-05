import 'package:flutter/material.dart';

class NotificacionesPage extends StatelessWidget {
  Widget _notificacionesPage(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 25, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Conocer el estatus del pedido por',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            _itemNotificacion(context, 'Email', enable: false),
            _itemNotificacion(context, 'Mensaje de texto', enable: false),
            _itemNotificacion(context, 'Notificación en la app', enable: true),
            SizedBox(height: 40),
            Text(
              'Recibir ofertas y descuentos por',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            _itemNotificacion(context, 'Email', enable: true),
            _itemNotificacion(context, 'Mensaje de texto', enable: false),
            _itemNotificacion(context, 'Notificación en la app', enable: false),
          ],
        ));
  }

  Widget _itemNotificacion(BuildContext context, String label, {bool enable}) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label),
            Switch(
              activeColor: Theme.of(context).primaryColor,
              value: enable == null ? false : enable,
              onChanged: (bool value) {},
            )
          ],
        ),
        Divider(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Preferencias de notificación'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: _notificacionesPage(context),
    );
  }
}
