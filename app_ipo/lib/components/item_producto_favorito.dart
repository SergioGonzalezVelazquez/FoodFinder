import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

class ItemProductoFavorito extends StatelessWidget {
  final Producto _producto;

  ItemProductoFavorito(this._producto);

  Widget _cardProducto(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          ConectorBBDD.endpointBBDD + _producto.imagen),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(_producto.nombre,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_producto.descripcion, style: TextStyle()),
            ),
            Text(_producto.precio.toStringAsFixed(2) + '€',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cardProducto(context);
  }
}
