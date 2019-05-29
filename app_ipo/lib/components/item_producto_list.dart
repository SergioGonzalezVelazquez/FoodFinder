import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/producto_details.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

class ItemProductoList extends StatelessWidget {
  final Producto _producto;
  Pedido _pedidoActual;

  ItemProductoList(this._producto, this._pedidoActual);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Divider(
          height: 25.0,
        ),
        new ListTile(
          //Imagen del producto
          leading: Container(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(60.0)),
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(ConectorBBDD.endpointBBDD +
                              _producto.imagen))),
          ),
          //Nombre del producto y precio
          title: new Row(
            children: <Widget>[
              new Text(
                _producto.nombre,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(
                _producto.precio.toStringAsFixed(2) + '€',
                style: new TextStyle(fontSize: 13.5),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          //Descripción
          subtitle: new Text(_producto.descripcion),

          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('Has pulsado:' + _producto.nombre);
            Route ruta = new MaterialPageRoute(
                builder: (context) => new ProductDetailsPage(
                      producto: _producto,
                      pedidoActual: _pedidoActual,
                    ));
            Navigator.push(context, ruta);
          },
        )
      ],
    );
  }
}