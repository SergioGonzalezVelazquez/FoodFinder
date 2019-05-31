import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/restaurantes/restaurantes_page.dart';

//alert dialog
import 'package:rich_alert/rich_alert.dart';

class OrderPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/orderPage";

  Pedido pedidoActual;

  OrderPage(this.pedidoActual);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Tu pedido'),
      centerTitle: true,
      iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Align(
              alignment: Alignment.center,
              child: Text(widget.pedidoActual.total.toStringAsFixed(2) + '€',
                  style: Theme.of(context).textTheme.title)),
        ),
      ],
    );
  }

  Widget _infoRestaurante() {
    
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Text(
          'Te atenderá:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Card(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      //Dirección del restaurante
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            size: 45,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Calle Nieves, 61',
                                  style: TextStyle(fontSize: 16)),
                              Text('BOLAÑOS DE CALATRAVA',
                                  style: TextStyle(fontSize: 16)),
                              Text('Tel. 926605213',
                                  style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new Container(
                        height: 1.5,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Hora entrega del pedido

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 45,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Hoy a las 14:20',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ))))
    ]);
  }

  Widget _seleccionMetodoPago() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
          ),
          child: Text(
            'Selecciona cómo quieres pagar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _itemMetodoPago('images/mastercard.png', 'MasterCard', 0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _itemMetodoPago('images/paypal.png', 'PayPal', 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _itemMetodoPago('images/efectivo.png', 'Efectivo Euros', 2),
        ),
      ],
    );
  }

  Widget _itemMetodoPago(String image, String nombre, int index) {
    return Card(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          //Check Button
          new Checkbox(
            value: false,
            onChanged: (bool value) {},
          ),
          //Imagen
          new Container(
              width: 45.0,
              height: 45.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new AssetImage(image)))),
          //Nombre
          SizedBox(
            width: 10,
          ),
          Text(
            nombre,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ));
  }

  Widget _observaciones() {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Text(
          'Observaciones',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: TextField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "¿Quieres hacer algún comentario?",
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      CheckboxListTile(
        title: Text(
            "No quiero recibir encuestas de satisfacción del pedido realizado",
            style: TextStyle(fontSize: 14)),
        value: false,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (newValue) {},
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      )
    ]);
  }

  Widget _direccionEntrega() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Revisa tu dirección de entrega:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            Text('Provincia*'),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Provincia',
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 25,
            ),
            Text('Localidad'),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Localidad',
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 25,
            ),
            Text('Nombre de vía*'),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Nombre de vía',
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 25,
            ),
            Text('Número*'),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Número',
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Bloque',
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Escalera',
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Número',
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _telefono() {
    return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Column(
          children: <Widget>[
            Text(
              '¡Necesitamos tu teléfono para que tu pedido llegue calentito!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Teléfono*',
              ),
              maxLines: 1,
              maxLength: 9,
            )
          ],
        ));
  }

  Widget _btnFinalizarPedido() {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      padding: EdgeInsets.only(
          top: 10,
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
                "Deseo guardar este método de pago para futuros pedidos",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            value: false,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (newValue) {},
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          MaterialButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RichAlertDialog(
                      //uses the custom alert dialog
                      alertTitle: richTitle("Alert title"),
                      alertSubtitle: richSubtitle("Subtitle"),
                      alertType: RichAlertType.SUCCESS,
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            /*Utilizamos popUntil para que se borren de la pila todas
                            las ventanas relacionadas con el proceso de compra. 
                             */
                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          },
                        )
                      ],
                    );
                  });
              //Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 14,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  "Finalizar Pedido".toUpperCase(),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          _infoRestaurante(),
          SizedBox(
            height: 15,
          ),
          _direccionEntrega(),
          SizedBox(
            height: 15,
          ),
          _telefono(),
          SizedBox(
            height: 15,
          ),
          _seleccionMetodoPago(),
          SizedBox(
            height: 15,
          ),
          _observaciones(),
        ],
      )),
      bottomNavigationBar: _btnFinalizarPedido(),
    );
  }
}
