import 'package:app_ipo/model/producto_model.dart';

class ProductoCantidad {
  Producto _producto;
  int _cantidad;
  double _importe;

  ProductoCantidad(Producto producto, int cantidad, {double importe}) {
    this._cantidad = cantidad;
    this._producto = producto;
    this._importe =
        (importe == null ? (_cantidad * _producto.precio) : importe);
  }

  Producto get producto => _producto;
  int get cantidad => _cantidad;
  double get importe => _importe;

  set cantidad(int cantidad) {
    this._cantidad = cantidad;
    this._importe = this._importe * this._producto.precio;
  }

  void aumentaCantidad() {
    this._cantidad++;
    this._importe += this._producto.precio;
  }

  void disminuyeCantidad() {
    if (cantidad > 0) {
      this._cantidad--;
      this._importe -= this._producto.precio;
    }
  }

  // Define that two ProductoCantidad are equal if their Products are equal
  bool operator ==(dynamic other) {
    return (other.producto == _producto);
  }
}
