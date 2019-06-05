import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ipo/pages/cart_page.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/model/user_model.dart';

class ProductDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final Producto producto;
  final Pedido pedidoActual;
  final User user;

  ProductDetailsPage(this.producto, this.pedidoActual, this.user);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetailsPage> {
  bool isFavorito;

  @override
  void initState() {
    super.initState();
    isFavorito = widget.user.isPlatoFavorito(widget.producto);
  }

  Widget _imagenProducto(BuildContext context) {
    return Container(
        //Imagen producto
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    ConectorBBDD.endpointBBDD + widget.producto.imagen),
                fit: BoxFit.fill)));
  }

  Widget _precioProducto(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
        child: Text(
          widget.producto.precio.toStringAsFixed(2) + '€',
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Widget _nombreProducto(BuildContext context) {
    return Text(
      widget.producto.nombre,
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _descripcionProducto(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 50,
            left: MediaQuery.of(context).size.width / 30,
            right: 10),
        child: Text(
          widget.producto.descripcion,
          //textAlign: TextAlign.center,
        ));
  }

  void _toggleFavoriteStatus() {
    if (isFavorito) {
      setState(() {
        isFavorito = false;
      });
      widget.user.quitarPlato(widget.producto);
      Fluttertoast.showToast(msg: "Eliminado de platos favoritos");
    } else {
      setState(() {
        isFavorito = true;
      });
      widget.user.insertarPlato(widget.producto);
      Fluttertoast.showToast(msg: "Añadido a platos favoritos");
    }
  }

  Widget _btnAniadirProducto() {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            widget.pedidoActual.insertarProducto(widget.producto);
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 14,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              "Añadir al pedido".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnFavorito(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent, // makes highlight invisible to
      onPressed: () {
        _toggleFavoriteStatus();
      },
      icon: new Icon(
        isFavorito ? Icons.favorite : Icons.favorite_border,
        color: Theme.of(context).primaryColor,
        size: 34,
      ),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      title: new Text(widget.producto.nombre),
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      actions: <Widget>[
        _btnFavorito(context),
        CartPage.cestaCompraBar(context, widget.pedidoActual, widget.user)
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _imagenProducto(context),
            _precioProducto(context),
            _nombreProducto(context),
            _descripcionProducto(context),
          ],
        ),
      ),
      bottomNavigationBar: _btnAniadirProducto(),
    );
  }
}
