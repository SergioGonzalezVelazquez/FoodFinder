import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

///Item del listado de productos en el carro de la compra
class ItemProductoCart extends StatefulWidget {
  final ProductoCantidad productoCantidad;
  final Pedido pedidoActual;
  final Animation animation;

  ItemProductoCart(this.productoCantidad, this.pedidoActual, this.animation);

  @override
  State<StatefulWidget> createState() {
    return ItemProductoCardState();
  }
}

class ItemProductoCardState extends State<ItemProductoCart> {
  Widget _selectorCantidad(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8.5,
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
                  widget.pedidoActual
                      .insertarProducto(widget.productoCantidad.producto);
                });
              },
              child: Icon(Icons.keyboard_arrow_up, color: Color(0xFFD3D3D3))),
          Text(
            widget.productoCantidad.cantidad.toString(),
            style: TextStyle(fontSize: 18),
          ),
          InkWell(
              onTap: () {
                if (widget.productoCantidad.cantidad > 1) {
                  setState(() {
                    widget.pedidoActual.reducirCantidadProducto(
                        widget.productoCantidad.producto);
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
      height: MediaQuery.of(context).size.height / 8.5,
      width: MediaQuery.of(context).size.height / 8.5,
      decoration: BoxDecoration(
        image: DecorationImage(
            image:  NetworkImage(ConectorBBDD.endpointBBDD +
                              widget.productoCantidad.producto.imagen),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(35.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Card(
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
                      widget.productoCantidad.producto.nombre,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.productoCantidad.producto.precio
                              .toStringAsFixed(2) +
                          ' €/ud',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        Text('Importe:', style: TextStyle(fontSize: 14.0)),
                        SizedBox(width: 10),
                        Text(
                            (widget.productoCantidad.producto.precio *
                                        widget.productoCantidad.cantidad)
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
              InkWell(
                onTap: (){
                  widget.pedidoActual.borrarProducto(widget.productoCantidad);
                },
                child: Icon(
                  Icons.cancel,
                  color: Color(0xFFD3D3D3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
