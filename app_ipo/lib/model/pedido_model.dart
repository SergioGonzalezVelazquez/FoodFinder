import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/restaurante_model.dart';
import 'package:app_ipo/components/observador_pedido.dart';

//fechas
import 'package:date_format/date_format.dart';

class Pedido {
  int _numPedido;
  int _idCliente;
  Restaurante _restaurante;
  int _estado; //2 = Completado, 0 = Cancelado, 1 = Pendiente
  String _fecha;
  double _total;
  double _subtotal;
  double _envio;
  double _descuento;

  //Listado de productos con su cantidad en el pedido
  List<ProductoCantidad> _listadoProductos = new List<ProductoCantidad>();

  List<ObservadorPedido> _observadores;

  Pedido(
      {int numPedido,
      double envio,
      double descuento,
      int estado,
      double importe,
      String fecha,
      Restaurante restaurante,
      List<ProductoCantidad> listadoProductos}) {
    this._numPedido = numPedido;
    this._envio = envio;
    this._descuento = descuento;
    this._estado = estado;
    this._restaurante = restaurante;
    this._fecha = (fecha == null) ? _fechaActual() : fecha;

    this._listadoProductos = (listadoProductos == null
        ? new List<ProductoCantidad>()
        : listadoProductos);
    this._subtotal = (importe == null ? _calculaImporte() : importe);
    this._calculaTotal();
    this._observadores = new List<ObservadorPedido>();
  }

  factory Pedido.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['productos'] as List;
    List<ProductoCantidad> listadoProductos =
        list.map((i) => ProductoCantidad.fromJson(i)).toList();
    return Pedido(
        numPedido: int.parse(jsonData['numPedido']),
        estado: int.parse(jsonData['estado']),
        fecha: jsonData['fecha'],
        envio: double.parse(jsonData['envio']),
        descuento: double.parse(jsonData['descuento']),
        restaurante: Restaurante.fromJson(jsonData['restaurante']),
        listadoProductos: listadoProductos);
  }

  int get estado => _estado;
  String get fecha => _fecha;
  int get numPedido => _numPedido;
  int get idCliente => _idCliente;
  double get descuento => _descuento;
  double get total => _total;
  double get subtotal => _subtotal;
  double get envio => _envio;
  Restaurante get restaurante => _restaurante;
  List<ProductoCantidad> get listadoProductos => _listadoProductos;

  void registrarObservador(ObservadorPedido o) {
    _observadores.add(o);
  }

  void eliminarObservador(ObservadorPedido o) {
    _observadores.remove(o);
  }

  double _calculaImporte() {
    double i = 0;
    _listadoProductos.forEach((p) => i += p.importe);
    return i;
  }

  void _calculaTotal() {
    this._total = (this._subtotal - (this.subtotal * (this._descuento / 100))) +
        this._envio;
  }

  void cancelarPedido() {
    if (_estado == 1) {
      //Si el pedido está en elaboración...
      _estado = 0;
    }
  }

  String _fechaActual() {
    final todayDate = DateTime.now();
    return formatDate(todayDate, [dd, '/', mm, '/', yyyy, ' ']);
  }

  int numProductos() {
    int n = 0;
    _listadoProductos.forEach((producto) => n += producto.cantidad);
    return n;
  }

  void insertarProducto(Producto producto) {
    //Comprobar si ese producto ya se encuentra en la cesta
    int index = _listadoProductos.indexOf(new ProductoCantidad(producto, 1));
    if (index < 0) {
      //Es un producto nuevo
      _listadoProductos.add(new ProductoCantidad(producto, 1));
    } else {
      //Ya está añadido, incrementamos su cantidad
      _listadoProductos[index].aumentaCantidad();
    }
    _subtotal += producto.precio;
    this._calculaTotal();
    _observadores.forEach((o) => o.updatePedido());
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

    _observadores.forEach((o) => o.updatePedido());
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
    _observadores.forEach((o) => o.updatePedido());
  }
}
