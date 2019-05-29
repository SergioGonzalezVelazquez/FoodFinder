import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/pedidos/pedido_details.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

class ItemPedidoList extends StatelessWidget {
  final Pedido _pedido;

  ItemPedidoList(this._pedido);

  Widget _printEstado() {
    String estado;
    Color color;

    switch (_pedido.estado) {
      case 0:
        {
          estado = 'Cancelado';
          color = Colors.red;
        }
        break;

      case 1:
        {
          estado = 'En elaboración';
          color = Colors.orange;
        }
        break;

      case 2:
        {
          estado = 'Completado';
          color = Colors.green;
        }
        break;

      default:
        {
          estado = 'Desconocido';
          color = Colors.black;
        }
        break;
    }

    return Text(
      estado,
      style: TextStyle(
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new ListTile(
          onTap: () {
            Route ruta = new MaterialPageRoute(
                builder: (context) => new PedidoDetailsPage(
                      pedido: _pedido,
                    ));
            Navigator.push(context, ruta);
          },
          //Logo del restaurante
          leading: Container(
            width: MediaQuery.of(context).size.width / 6.5,
            height: MediaQuery.of(context).size.width / 6.5,
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(ConectorBBDD.endpointBBDD +
                        _pedido.restaurante.imagenLogo))),
          ),
          //Nombre del restaurante y fecha del pedido
          title: new Row(
            children: <Widget>[
              new Text(
                _pedido.restaurante.nombre,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(
                _pedido.fecha,
                style: new TextStyle(fontSize: 13.5),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),

          //Precio, número de productos, estado del pedido
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Total: €' +
                  _pedido.total.toStringAsFixed(2) +
                  ' (' +
                  _pedido.numProductos().toString() +
                  ' productos)'),
              Row(children: <Widget>[Text('A domicilio - '), _printEstado()])
            ],
          ),
        ),
        new Divider(
          height: 25.0,
        ),
      ],
    );
  }
}
