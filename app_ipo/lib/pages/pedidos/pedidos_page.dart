import 'package:flutter/material.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:app_ipo/components/item_pedido_list.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/components/listview_pedidos.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/model/pedido_model.dart';

class PedidosPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/pedidos";
  User user;

  PedidosPage({this.user});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PedidosPageState();
  }
}

class _PedidosPageState extends State<PedidosPage> {
  //Listado de todos los restaurantes recuperados del servidor
  List<Pedido> listPedidos;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPedidos = new List<Pedido>();
    _fetchPedidos();
  }

  void _fetchPedidos() async {
    setState(() {
      isLoading = true;
    });

    Restaurante restaurante = new Restaurante(
      nombre: 'Telepizza',
      imagenLogo: "images/restaurants/logo_telepizza.png",
      imagenFondo: "images/restaurants/fondo_telepizza.jpg",
      categoria: 'Italiana, Pizza',
      valoracion: 4,
      numValoraciones: 1872,
      pedidoMinimo: 6.95,
      distancia: '1.7',
      envio: 0,
    );
    Pedido pedido1 = new Pedido(
        numPedido: 3243,
        envio: 2.9,
        fecha: '31/03/2019',
        restaurante: restaurante,
        descuento: 0,
        estado: 2);

    Pedido pedido2 = new Pedido(
        numPedido: 3343,
        envio: 2.9,
        fecha: '31/03/2019',
        restaurante: restaurante,
        descuento: 0,
        estado: 0);
    Pedido pedido3 = new Pedido(
        numPedido: 3643,
        envio: 2.9,
        fecha: '31/03/2019',
        restaurante: restaurante,
        descuento: 0,
        estado: 1);

    Producto producto1 = new Producto(
        id: 54,
        nombre: 'Vulcano Nachos',
        imagen: "images/products/telepizza_vulcanoNachos.jpg",
        descripcion: 'Nuestra masa de siempre cubierta de crujiente',
        precio: 6.95);

    Producto producto2 = new Producto(
        id: 23,
        nombre: 'Sweet con Caja Roja',
        imagen: "images/products/telepizza_cajaRoja.jpg",
        descripcion: 'Nuestra masa de siempre cubierta de crujiente',
        precio: 5.95);

    Producto producto3 = new Producto(
        id: 890,
        nombre: 'La Ibérica de Telepizza',
        imagen: "images/products/telepizza_iberica.jpg",
        descripcion: 'Nuestra masa de siempre cubierta de crujiente',
        precio: 8.95);

    pedido1.insertarProducto(producto1);
    pedido1.insertarProducto(producto1);
    pedido1.insertarProducto(producto1);
    pedido1.insertarProducto(producto2);
    pedido1.insertarProducto(producto3);

    pedido2.insertarProducto(producto1);
    pedido3.insertarProducto(producto1);
    pedido2.insertarProducto(producto1);
    pedido2.insertarProducto(producto2);
    pedido3.insertarProducto(producto3);

    listPedidos.add(pedido1);

    listPedidos.add(pedido2);

    listPedidos.add(pedido3);

    print('pedido ok');

    setState(() {
      isLoading = false;
    });
  }

  Widget _sinPedidos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
            width: 70.0,
            height: 70.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage('images/shopping_basket.png')))),
        SizedBox(height: 16),
        Text(
          'Haz tu primer pedido',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
              'Cuando hayas hecho un pedido te aparecerá aquí toda la información del mismo para que puedas repetirlo en futuras ocasiones'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 14,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                "Buscar Restaurantes".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listadoPedidos() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listPedidos.length,
          itemBuilder: (context, int item) =>
              new ItemPedidoList(listPedidos[item])),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: (listPedidos.length == 0)
            ? _sinPedidos()
            : new Column(children: <Widget>[
                SizedBox(height: 15),
                PedidosList(listPedidos)
              ]));
  }
}
