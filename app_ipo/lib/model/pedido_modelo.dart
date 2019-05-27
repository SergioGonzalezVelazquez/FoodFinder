import 'package:app_ipo/model/producto_model.dart';

class ModeloPedido {
  int _id;
  double _envio;
  double _descuento;
  double _importe;

  //Listado de productos
  List<ModeloProducto> _productos = new List<ModeloProducto>();

  ModeloPedido({int id, double envio, double descuento, double importe}) {
    this._id = id;
    this._envio = envio;
    this._descuento = descuento;
    this._importe = (importe == null ? 0 : importe);
  }
}
