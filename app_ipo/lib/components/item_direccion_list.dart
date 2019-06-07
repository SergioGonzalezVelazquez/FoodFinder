import 'package:flutter/material.dart';
import 'package:app_ipo/model/direccion_model.dart';

///Item del listado de direcciones guardadas por un usuario.
///Se utiliza en Configuración -- Direcciones de entrega
class ItemDireccionList extends StatelessWidget {
  final Direccion _direccion;

  ItemDireccionList(this._direccion);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
          //Nombre de la dirección y botón editar
          title: new Row(
            children: <Widget>[
              new Text(
                _direccion.nombre,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),

          //Datos dirección
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_direccion.nombreVia+ ', nº '+ _direccion.numero.toString()),
              Text(_direccion.localidad+ ', '+ _direccion.codigoPostal.toString()),
              Text(_direccion.provincia),
            ],
          ),
        ),
        new Divider(
          height: 15.0,
        ),
      ],
    );
  }
}
