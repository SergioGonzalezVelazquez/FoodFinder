import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/restaurantes_page.dart';

//alert dialog
import 'package:rich_alert/rich_alert.dart';

class OrderPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/orderPage";

  Pedido pedidoActual;

  OrderPage({this.pedidoActual});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  Widget _btnFinalizarPedido() {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      padding: EdgeInsets.only(
          top: 10,
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
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
      appBar: AppBar(
        title: Text('Tu pedido'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: <Widget>[],
      ),
      bottomNavigationBar: _btnFinalizarPedido(),
    );
  }
}
