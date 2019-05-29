import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/components/item_pedido_list.dart';
import 'package:app_ipo/pages/cart_page.dart';

class PedidoDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final Pedido pedido;

  PedidoDetailsPage({this.pedido});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PedidoDetailsState();
  }
}

class _PedidoDetailsState extends State<PedidoDetailsPage> {
  int estadoPedido;

  @override
  void initState() {
    /*Queremos que el estado del pedido sea una propiedad dinámica para que,
    al cancelar un pedido en elaboración se produzca un cambio en la interfaz*/
    super.initState();
    estadoPedido = widget.pedido.estado;
  }

  @override
  Widget _btnVerRestaurante() {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 2.7,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Center(
          child: Text(
            "Ver restaurante",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnRepetirPedido() {
    return MaterialButton(
      onPressed: () {
        Pedido nuevoPedido = new Pedido(
          envio: widget.pedido.envio,
          descuento: widget.pedido.descuento,
          estado: 1, //En elaboración
          restaurante: widget.pedido.restaurante,
          listadoProductos: widget.pedido.listadoProductos,
        );
        Route ruta = new MaterialPageRoute(
            builder: (context) => new CartPage(pedidoActual: nuevoPedido));
        Navigator.push(context, ruta);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 2.7,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "Repetir pedido",
            style: TextStyle(
              color: Theme.of(context).bottomAppBarColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnCancelarPedido() {
    return MaterialButton(
      onPressed: () {
        print('cancelado');
        widget.pedido.cancelarPedido();
        setState(() {
          estadoPedido = widget.pedido.estado;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "Cancelar pedido",
            style: TextStyle(
              color: Theme.of(context).bottomAppBarColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _resumenPedido() {
    return Card(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Titulo y nombre del pedido
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Resumen del pedido',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('#41747047',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.pedido.listadoProductos.length,
                itemBuilder: (context, int item) =>
                    _resumenPedidoItem(widget.pedido.listadoProductos[item])),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'subtotal'.toUpperCase(),
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '€' + widget.pedido.subtotal.toStringAsFixed(2),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'total'.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text('€' + widget.pedido.total.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.pedido.restaurante.nombre,
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Calle Luis Vélez de Guevara, 6, Madrid, 28012',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumenPedidoItem(ProductoCantidad productoCantidad) {
    String itemText = productoCantidad.producto.nombre;
    if (productoCantidad.cantidad > 1) {
      itemText += ' (x' + productoCantidad.cantidad.toString() + ')';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          itemText,
          style: TextStyle(fontSize: 14),
        ),
        Text(
          productoCantidad.importe.toStringAsFixed(2),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _llamarRestaurante() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Titulo y nombre del pedido
                Text(
                  '¿Sigues necesitando ayuda?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Si no podemos seguir ayudándote, simplemente llama al restaurante',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          new Container(
            height: 1.5,
            color: Theme.of(context).buttonColor,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Llama a ' + widget.pedido.restaurante.nombre,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Detalles del pedido'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              ItemPedidoList(widget.pedido),
              SizedBox(
                height: 10,
              ),

              /* Si el pedido está en elaboración (pedido.estado = 1), se muestra un 
              único botón para cancelar el pedido. Por el contrario, si
              el pedido está completado o cancelado, se muestran dos botones
              alineados horizontalmente: verRestaurante y repetirPedido
               */
              ((widget.pedido.estado != 1)
                  ? (new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _btnVerRestaurante(),
                        _btnRepetirPedido(),
                      ],
                    ))
                  : _btnCancelarPedido()),
              SizedBox(
                height: 25,
              ),
              _resumenPedido(),
              SizedBox(
                height: 25,
              ),
              _llamarRestaurante(),
            ],
          ),
        ),
      ),
    );
  }
}
