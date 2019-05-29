import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/components/item_pedido_list.dart';

class PedidosList extends StatefulWidget {
  List<Pedido> listPedidos = List();

  PedidosList(this.listPedidos);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PedidosListState();
  }
}

class _PedidosListState extends State<PedidosList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.listPedidos.length,
        itemBuilder: (context, int item) =>
            new ItemPedidoList(widget.listPedidos[item]));
  }
}
