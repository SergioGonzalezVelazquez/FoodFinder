import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/components/observador_pedido.dart';

class Pedido {
  int _numPedido;
  int _idCliente;
  double _total;
  double _subtotal;
  double _envio;
  double _descuento;
  String _estado;

  //Listado de productos con su cantidad en el pedido
  List<ProductoCantidad> _listadoProductos = new List<ProductoCantidad>();

  List<ObservadorPedido> _observadores;

  Pedido(
      {int numPedido,
      double envio,
      double descuento,
      String estado,
      double importe}) {
    this._numPedido = numPedido;
    this._envio = envio;
    this._descuento = descuento;
    this._estado = estado;
    this._subtotal = (importe == null ? 0 : _subtotal);
    this._calculaTotal();
    _listadoProductos = new List<ProductoCantidad>();
  }

  String get estado => _estado;
  int get numPedido => _numPedido;
  int get idCliente => _idCliente;
  double get descuento => _descuento;
  double get total => _total;
  double get subtotal => _subtotal;
  double get envio => _envio;
  List<ProductoCantidad> get listadoProductos => _listadoProductos;

  void registrarObservador(ObservadorPedido o) {
    _observadores.add(o);
  }

  void eliminarObservador(ObservadorPedido o) {
    _observadores.remove(o);
  }

  void _calculaTotal() {
    this._total = this._subtotal + this._envio - this._descuento;
  }

  int numProductos() {
    int n = 0;
    _listadoProductos.forEach((producto) => n += producto.cantidad);
    return n;
  }

  void insertarProducto(Producto producto) {
    //Comprobar si ese producto ya se encuentra en la cesta
    int index = _listadoProductos.indexOf(new ProductoCantidad(producto, 1));
    print('Indice de' + producto.nombre + ' :' + index.toString());
    if (index < 0) {
      //Es un producto nuevo
      _listadoProductos.add(new ProductoCantidad(producto, 1));
    } else {
      //Ya está añadido, incrementamos su cantidad
      _listadoProductos[index].aumentaCantidad();
    }
    _subtotal += producto.precio;
    this._calculaTotal();
  }

  void reducirCantidadProducto(Producto producto) {
    //Comprobar si ese producto ya se encuentra en la cesta
    int index = _listadoProductos.indexOf(new ProductoCantidad(producto, 1));
    int cantidad = _listadoProductos[index].cantidad;

    if (cantidad > 1) {
      _listadoProductos[index].disminuyeCantidad();
      _subtotal -= producto.precio;
      this._calculaTotal();
    }
  }

  void borrarProducto(ProductoCantidad productoCantidad) {
    int index = _listadoProductos.indexOf(productoCantidad);
    //Borra el producto del listado de productos
    if (index >= 0) {
      _subtotal -= productoCantidad.producto.precio * productoCantidad.cantidad;
      _listadoProductos.removeAt(index);
      this._calculaTotal();
    }
    _observadores.forEach((o) => o.removeItem(productoCantidad, index));
  }
}
