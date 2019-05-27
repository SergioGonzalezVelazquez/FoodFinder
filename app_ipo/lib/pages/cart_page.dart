import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/components/item_producto_cart.dart';
import 'package:app_ipo/pages/order_page.dart';

class CartPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/cartPage";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  Widget _btnPagar() {
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, OrderPage.nombreRuta);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "Pasar por caja".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoImporte(String concepto, double importe) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          concepto,
          style: TextStyle(
              color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          importe.toStringAsFixed(2) + ' €',
          style: TextStyle(
              color: Color(0xFF6C6D6D),
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _importeTotal() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Total:".toUpperCase(),
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "26.50 €",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _totalPedido() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
          _infoImporte('Subtotal', 23),
          SizedBox(height: 10.0),
          _infoImporte('Descuento', 0),
          SizedBox(height: 10.0),
          _infoImporte('Envío', 3.9),
          SizedBox(height: 10.0),
          Divider(height: 2.0),
          SizedBox(height: 20.0),
          _importeTotal(),
          SizedBox(height: 20.0),
          _btnPagar(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ItemProductoCart(new ModeloProducto(
              nombre: 'La Ibérica de Telepizza',
              imagen: "images/products/telepizza_iberica.jpg",
              descripcion: 'Nuestra masa de siempre cubierta de crujiente',
              precio: 8.95)),
          ItemProductoCart(new ModeloProducto(
              nombre: 'La Ibérica de Telepizza',
              imagen: "images/products/telepizza_iberica.jpg",
              descripcion: 'Nuestra masa de siempre cubierta de crujiente',
              precio: 8.95)),
        ],
      ),
      bottomNavigationBar: _totalPedido(),
    );
  }
}
