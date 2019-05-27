import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';

class ItemProductoCart extends StatefulWidget {
  final ModeloProducto producto;
  ItemProductoCart(this.producto);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ItemProductoCardState();
  }
}

class ItemProductoCardState extends State<ItemProductoCart> {
  int cantidad;

  @override
  void initState() {
    super.initState();
    cantidad = 1;
  }

  Widget _selectorCantidad(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      width: MediaQuery.of(context).size.width / 9,
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Color(0xFFD3D3D3)),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  cantidad++;
                });
              },
              child: Icon(Icons.keyboard_arrow_up, color: Color(0xFFD3D3D3))),
          Text(
            cantidad.toString(),
            style: TextStyle(fontSize: 18),
          ),
          InkWell(
              onTap: () {
                if (cantidad > 1) {
                  setState(() {
                    cantidad--;
                  });
                }
              },
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFFD3D3D3),
              )),
        ],
      ),
    );
  }

  Widget _imagenProducto(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      width: MediaQuery.of(context).size.height / 9,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(widget.producto.imagen), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(35.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _selectorCantidad(context),
            SizedBox(width: 20.0),
            _imagenProducto(context),
            SizedBox(width: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.producto.nombre,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.producto.precio.toStringAsFixed(2) + ' €/ud',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Text('Importe:', style: TextStyle(fontSize: 14.0)),
                      SizedBox(width: 10),
                      Text(
                          (widget.producto.precio * cantidad)
                                  .toStringAsFixed(2) +
                              ' €',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.cancel,
                color: Color(0xFFD3D3D3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
