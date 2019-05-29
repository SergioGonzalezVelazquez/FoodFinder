import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/components/item_producto_cart.dart';
import 'package:app_ipo/components/observador_pedido.dart';
import 'package:app_ipo/pages/order_page.dart';
import 'package:app_ipo/model/pedido_model.dart';

class CartPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/cartPage";
  Pedido pedidoActual;

  CartPage({this.pedidoActual});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> implements ObservadorPedido {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  double subtotal;

  @override
  void initState() {
    super.initState();
    widget.pedidoActual.registrarObservador(this);
    subtotal = widget.pedidoActual.subtotal;
  }

  @override
  void dispose() {
    super.dispose();
    widget.pedidoActual.eliminarObservador(this);
  }

  Widget _btnPagar() {
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, OrderPage.nombreRuta);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "Pasar por caja".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoImporte(String concepto, double importe) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          concepto,
          style: TextStyle(
              color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          importe.toStringAsFixed(2) + ' €',
          style: TextStyle(
              color: Color(0xFF6C6D6D),
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _importeTotal() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Total:".toUpperCase(),
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.pedidoActual.total.toStringAsFixed(2) + " €",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _totalPedido() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
          _infoImporte('Subtotal', subtotal),
          SizedBox(height: 10.0),
          _infoImporte('Descuento', widget.pedidoActual.descuento),
          SizedBox(height: 10.0),
          _infoImporte('Envío', widget.pedidoActual.envio),
          SizedBox(height: 10.0),
          Divider(height: 2.0),
          SizedBox(height: 20.0),
          _importeTotal(),
          SizedBox(height: 20.0),
          _btnPagar(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _btnCestaVacia() {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
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
                  "Añadir platos".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _cestaVacia() {
    return Center(
      child: Column(
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
            'Pedido vacío',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Elige algo rico del menú'),
        ],
      ),
    );
  }

/*
  Widget _vistaCesta() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.pedidoActual.listadoProductos.length,
            itemBuilder: (context, int item) => new ItemProductoCart(
                widget.pedidoActual.listadoProductos[item],
                widget.pedidoActual))
      ],
    );
  }

*/
  Widget _vistaCesta() {
    return AnimatedList(
        key: _listKey,
        initialItemCount: widget.pedidoActual.listadoProductos.length,
        itemBuilder: (context, int item, animation) => new ItemProductoCart(
            widget.pedidoActual.listadoProductos[item],
            widget.pedidoActual,
            animation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
        centerTitle: true,
      ),
      body: (widget.pedidoActual.listadoProductos.length > 0)
          ? _vistaCesta()
          : _cestaVacia(), //Default
      bottomNavigationBar: (widget.pedidoActual.listadoProductos.length > 0)
          ? _totalPedido()
          : _btnCestaVacia(),
    );
  }

  @override
  void removeItem(ProductoCantidad removedItem, int removeIndex) {
    // TODO: implement removeItem
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return ItemProductoCart(removedItem, widget.pedidoActual, animation);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }

  @override
  void updatePedido() {
    if (this.mounted) {
      setState(() {
        subtotal = widget.pedidoActual.subtotal;
      });
    }
  }
}
