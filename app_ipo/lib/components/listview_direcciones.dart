import 'package:flutter/material.dart';
import 'package:app_ipo/model/direccion_model.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/components/item_direccion_list.dart';
import 'package:app_ipo/pages/configuracion/direccion_nueva_page.dart';

class DireccionesList extends StatefulWidget {
  List<Direccion> listDirecciones = List();
  User user;

  DireccionesList(this.listDirecciones, this.user);
  @override
  State<StatefulWidget> createState() {
    return _DireccionesListState();
  }
}

class _DireccionesListState extends State<DireccionesList> {
  @override
  void initState() {
    super.initState();
  }

  Widget _sinDirecciones(BuildContext context) {
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
                      image: new AssetImage('images/address.png')))),
          SizedBox(height: 16),
          Text(
            'No se han guardado direcciones',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Crea y guarda direcciones de entrega para hacer tus pedidos fácilmente',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 40),
          _btnNuevaDireccion(context)
        ],
      ),
    );
  }

  Widget _btnNuevaDireccion(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        Route ruta = new MaterialPageRoute(
            builder: (context) => new DireccionNuevaPage(widget.user));
        Navigator.push(context, ruta);
      },
      child: Center(
        child: Text(
          "Añade una dirección",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.listDirecciones.length == 0)
        ? _sinDirecciones(context)
        : (new Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.listDirecciones.length,
                itemBuilder: (context, int item) =>
                    new ItemDireccionList(widget.listDirecciones[item]))
          ]));
  }
}
