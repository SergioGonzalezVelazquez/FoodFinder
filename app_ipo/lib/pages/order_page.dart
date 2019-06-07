import 'package:flutter/material.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:app_ipo/pages/restaurantes/restaurantes_page.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/direccion_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

//alert dialog
import 'package:rich_alert/rich_alert.dart';

class OrderPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/orderPage";
  final Pedido pedidoActual;
  final User user;

  OrderPage(this.pedidoActual, this.user);

  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _numero = TextEditingController();
  TextEditingController _localidad = TextEditingController();
  TextEditingController _provincia = TextEditingController();
  TextEditingController _nombreVia = TextEditingController();
  TextEditingController _codigoPostal = TextEditingController();
  TextEditingController _bloque = TextEditingController();
  TextEditingController _escalera = TextEditingController();
  TextEditingController _piso = TextEditingController();
  TextEditingController _telefono = TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false; //Validar textField
  bool _efectivo = false; //Selección método pago
  bool _paypal = false; //Selección método pago
  bool _mastercard = false; //Selección método pago
  bool _encuestas = false; //Observaciones
  bool _metodoPago = false;

  @override
  void initState() {
    if (widget.user.direcciones.length != 0) {
      Direccion direccion = widget.user.direcciones.last;
      _localidad.text = direccion.localidad;
      _nombreVia.text = direccion.nombreVia;
      _provincia.text = direccion.provincia;
      _numero.text = direccion.numero.toString();
      _codigoPostal.text = direccion.codigoPostal.toString();

      if (direccion.bloque != null) {
        _bloque.text = direccion.bloque;
      }
      if (direccion.escalera != null) {
        _escalera.text = direccion.escalera;
      }
      if (direccion.piso != null) {
        _piso.text = direccion.piso;
      }
      if (widget.user.telefono != null) {
        _telefono.text = widget.user.telefono;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _numero.dispose();
    _localidad.dispose();
    _provincia.dispose();
    _nombreVia.dispose();
    _codigoPostal.dispose();
    _bloque.dispose();
    _escalera.dispose();
    _piso.dispose();
    _telefono.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Tu pedido'),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Align(
              alignment: Alignment.center,
              child: Text(widget.pedidoActual.total.toStringAsFixed(2) + '€',
                  style: Theme.of(context).textTheme.title)),
        ),
      ],
    );
  }

  Widget _infoRestaurante() {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Text(
          'Te atenderá:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Card(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      //Dirección del restaurante
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.store,
                            size: 45,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Calle Nieves, 61',
                                  style: TextStyle(fontSize: 16)),
                              Text('BOLAÑOS DE CALATRAVA',
                                  style: TextStyle(fontSize: 16)),
                              Text('Tel. 926605213',
                                  style: TextStyle(fontSize: 16))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new Container(
                        height: 1.5,
                        color: Theme.of(context).buttonColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Hora entrega del pedido
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 45,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Hoy a las 14:20',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ))))
    ]);
  }

  Widget _seleccionMetodoPago() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
          ),
          child: Text(
            'Selecciona cómo quieres pagar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _itemMetodoPago('images/mastercard.png', 'MasterCard',
                checkbox: Checkbox(
                    value: _mastercard,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          _paypal = false;
                          _efectivo = false;
                        }
                        _mastercard = value;
                      });
                    }))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _itemMetodoPago('images/paypal.png', 'PayPal',
                checkbox: Checkbox(
                    value: _paypal,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          _efectivo = !value;
                          _mastercard = !value;
                        }
                        _paypal = value;
                      });
                    }))),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _itemMetodoPago('images/efectivo.png', 'Efectivo Euros',
                checkbox: Checkbox(
                    value: _efectivo,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          _mastercard = !value;
                          _paypal = !value;
                        }
                        _efectivo = value;
                      });
                    }))),
      ],
    );
  }

  Widget _itemMetodoPago(String image, String nombre, {Checkbox checkbox}) {
    return Card(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          //Check Button
          checkbox,
          //Imagen
          new Container(
              width: 45.0,
              height: 45.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new AssetImage(image)))),
          SizedBox(
            width: 10,
          ),
          //Nombre
          Text(
            nombre,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ));
  }

  Widget _observaciones() {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Text(
          'Observaciones',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: TextField(
              style: TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                hintText: "¿Quieres hacer algún comentario?",
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      CheckboxListTile(
        title: Text(
            "No quiero recibir encuestas de satisfacción del pedido realizado",
            style: TextStyle(fontSize: 14)),
        value: _encuestas,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (bool value) {
          setState(() {
            _encuestas = value;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      )
    ]);
  }

  Widget _itemTextField(
      String label, bool obligatorio, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          controller: controller,
          validator: (value) {
            if ((value.isEmpty) && (obligatorio)) {
              return 'Por favor, introduzca ' + label.toLowerCase();
            } else {
              return null;
            }
          },
          maxLines: 1,
          decoration: InputDecoration(
              labelText: label + (obligatorio ? '*' : ''),
              labelStyle: TextStyle(fontSize: 14))),
    );
  }

  Widget _direccionEntrega() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Revisa tu dirección de entrega:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            _itemTextField('Provincia', true, _provincia),
            SizedBox(
              height: 25,
            ),
            _itemTextField('Localidad', true, _localidad),
            SizedBox(
              height: 25,
            ),
            _itemTextField('Codigo Postal', true, _codigoPostal),
            SizedBox(
              height: 25,
            ),
            _itemTextField('Nombre de vía', true, _nombreVia),
            SizedBox(
              height: 25,
            ),
            _itemTextField('Número', true, _numero),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _itemTextField('Bloque', false, _bloque),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _itemTextField('Escalera', false, _escalera),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _itemTextField('Piso', false, _piso),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _widgetTelefono() {
    return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Column(
          children: <Widget>[
            Text(
              '¡Necesitamos tu teléfono para que tu pedido llegue calentito!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _telefono,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor, introduzca su teléfono';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Teléfono*',
              ),
              maxLines: 1,
              maxLength: 9,
            )
          ],
        ));
  }

  Widget _btnFinalizarPedido() {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      padding: EdgeInsets.only(
          top: 10,
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text(
                "Deseo guardar este método de pago para futuros pedidos",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            value: _metodoPago,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool value) {
              setState(() {
                _metodoPago = value;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          MaterialButton(
            onPressed: () {
              _validarPedido();
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

  void _validarPedido() {
    if (_key.currentState.validate()) {
      // No any error en los datos de entrega
      //Comprobamos que se ha seleccionado un método de pago
      if (_paypal || _efectivo || _mastercard) {
        _key.currentState.save();
        widget.user.insertarPedido(widget.pedidoActual);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _dialogPedidoFinalizado();
            });
      } else {
        Fluttertoast.showToast(msg: "Por favor, seleccione un método de pago");
      }
    } else {
      //Error en los datos de entrega
      setState(() {
        _validate = true;
      });
    }
  }

  RichAlertDialog _dialogPedidoFinalizado() {
    return RichAlertDialog(
      //uses the custom alert dialog
      alertTitle: richTitle("¡Hemos recibido tu pedido!"),
      alertSubtitle: richSubtitle("Lo recibirás hoy a las 14:20"),
      alertType: RichAlertType.SUCCESS,
      actions: <Widget>[
        FlatButton(
            child: Text("ACEPTAR"),
            onPressed: () {
              Route ruta = new MaterialPageRoute(
                  builder: (context) => new RestaurantesPage(
                        widget.user,
                      ));
              Navigator.pushReplacement(context, ruta);
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Form(
        key: _key,
        autovalidate: _validate,
        child: Column(
          children: <Widget>[
            _infoRestaurante(),
            SizedBox(
              height: 15,
            ),
            _direccionEntrega(),
            SizedBox(
              height: 15,
            ),
            _widgetTelefono(),
            SizedBox(
              height: 15,
            ),
            _seleccionMetodoPago(),
            SizedBox(
              height: 15,
            ),
            _observaciones(),
          ],
        ),
      )),
      bottomNavigationBar: _btnFinalizarPedido(),
    );
  }
}
