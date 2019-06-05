import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/components/item_producto_list.dart';
import 'package:app_ipo/model/user_model.dart';

class RestaurantMenus extends StatefulWidget {
  final List<Producto> productos;
  final Pedido pedidoActual;
  final double descuento;
  final User user;

  RestaurantMenus(this.productos, this.pedidoActual, this.user,
      {this.descuento = 0});

  @override
  State<StatefulWidget> createState() {
    return _RestaurantMenuState();
  }
}

class _RestaurantMenuState extends State<RestaurantMenus> {
  @override
  Widget build(BuildContext context) {
    if ((widget.productos == null) || widget.productos.length == 0) {
      return new Container(
        child: new Center(
          child: new Text("No hay productos disponibles"),
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Visibility(
            visible: widget.descuento > 0,
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: new Text(
                widget.descuento.toStringAsFixed(0) +
                    '% de dto. en todos los productos',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.productos.length,
                itemBuilder: (context, int item) => new ItemProductoList(
                    widget.productos[item], widget.pedidoActual, widget.user)),
          ),
        ],
      );
    }
  }
}
