import 'package:flutter/material.dart';

//my own imports
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/pages/restaurantes/restaurant_details.dart';
import 'package:app_ipo/components/item_pedido_list.dart';
import 'package:app_ipo/pages/cart_page.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/custom_icons_icons.dart';

class PedidoDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final Pedido _pedido;
  final User _user;

  PedidoDetailsPage(this._pedido, this._user);

  @override
  State<StatefulWidget> createState() {
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
    estadoPedido = widget._pedido.estado;
  }

  Widget _btnVerRestaurante() {
    return MaterialButton(
      onPressed: () {
        Route ruta = new MaterialPageRoute(
            builder: (context) => new RestaurantDetailsPage(
                widget._pedido.restaurante, widget._user));
        Navigator.push(context, ruta);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 3,
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
          envio: widget._pedido.envio,
          descuento: widget._pedido.descuento,
          estado: 1, //En elaboración
          restaurante: widget._pedido.restaurante,
          listadoProductos: widget._pedido.listadoProductos,
        );
        Route ruta = new MaterialPageRoute(
            builder: (context) =>
                new CartPage(widget._user, pedidoActual: nuevoPedido));
        Navigator.push(context, ruta);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 3,
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
        widget._pedido.cancelarPedido();
        setState(() {
          estadoPedido = widget._pedido.estado;
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

  Widget estadoPedidoEnCurso() {
    return Card(
        child: Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _circuloEstado(Icons.done, true),
              _separadorHorizontal(true),
              _circuloEstado(CustomIcons.cooking, true),
              _separadorHorizontal(false),
              _circuloEstado(CustomIcons.delivery, false),
              _separadorHorizontal(false),
              _circuloEstado(Icons.restaurant, false),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _labelEstado('Recibido', true),
              _labelEstado('Preparando', true),
              _labelEstado('De camino', false),
              _labelEstado('Entregado', false)
            ],
          ),
        ],
      ),
    ));
  }

  Widget _labelEstado(String label, bool completed) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
          fontSize: 12,
          color: completed ? Theme.of(context).primaryColor : Colors.grey),
    );
  }

  Widget _separadorHorizontal(bool completed) {
    return new Container(
        height: 1.5,
        width: MediaQuery.of(context).size.width / 12,
        color: completed ? Theme.of(context).primaryColor : Colors.grey);
  }

  Widget _circuloEstado(IconData icon, bool completed) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 8,
          height: MediaQuery.of(context).size.width / 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: completed
                  ? Theme.of(context).primaryColor
                  : Colors.grey, //                   <--- border color
              width: 2.0,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: completed ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
        ),
      ],
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
                itemCount: widget._pedido.listadoProductos.length,
                itemBuilder: (context, int item) =>
                    _resumenPedidoItem(widget._pedido.listadoProductos[item])),
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
                  '€' + widget._pedido.subtotal.toStringAsFixed(2),
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
                Text('€' + widget._pedido.total.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget._pedido.restaurante.nombre,
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
                    'Llama a ' + widget._pedido.restaurante.nombre,
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

  _showAlertRate() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.star_border,
                              color: Theme.of(context).primaryColor,
                              size: 30.0),
                          Icon(Icons.star_border,
                              color: Theme.of(context).primaryColor,
                              size: 30.0),
                          Icon(
                            Icons.star_border,
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Da tu opinión a los demás",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Escribir una opinión".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _valorarPedido() {
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
                  '¿Cómo fue tu pedido?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Su opinión ayuda a otros a encontrar restaurantes geniales',
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
              onTap: () {
                _showAlertRate();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.rate_review,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Deja tu valoración',
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
              ItemPedidoList(widget._pedido, widget._user),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: widget._pedido.estado == 1,
                  child: estadoPedidoEnCurso()),
              SizedBox(
                height: 10,
              ),

              /* Si el pedido está en elaboración (pedido.estado = 1), se muestra un 
              único botón para cancelar el pedido. Por el contrario, si
              el pedido está completado o cancelado, se muestran dos botones
              alineados horizontalmente: verRestaurante y repetirPedido
               */
              ((widget._pedido.estado != 1)
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

              /* Un pedido sólo se puede valorar cuando se ha completado
              (pedido.estado == 2)
               */
              (widget._pedido.estado == 2)
                  ? _valorarPedido()
                  : Container(
                      height: 0,
                    ),
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
