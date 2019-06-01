import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/components/item_pedido_list.dart';

class PedidosList extends StatefulWidget {
  List<Pedido> listPedidos = List();

  PedidosList(this.listPedidos);
  @override
  State<StatefulWidget> createState() {
    return _PedidosListState();
  }
}

class _PedidosListState extends State<PedidosList> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return (widget.listPedidos.length == 0)
        ? _sinPedidos()
        : (new Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.listPedidos.length,
                itemBuilder: (context, int item) =>
                    new ItemPedidoList(widget.listPedidos[item]))
          ]));
  }
}
