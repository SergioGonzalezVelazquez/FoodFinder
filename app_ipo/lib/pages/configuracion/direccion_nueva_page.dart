import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/model/direccion_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DireccionNuevaPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/favoritos";
  final User user;
  DireccionNuevaPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return _DireccionNuevaState();
  }
}

class _DireccionNuevaState extends State<DireccionNuevaPage> {
  String _numero,
      _localidad,
      _provincia,
      _nombreVia,
      _codigoPostal,
      _nombre,
      _bloque,
      _escalera,
      _piso;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _item(String label, bool obligatorio, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          validator: (value) {
            if ((value.isEmpty) && (obligatorio)) {
              return 'Introduzca ' + label.toLowerCase();
            } else {
              return null;
            }
          },
          onSaved: (String val) {
            _formSaved(val, index);
          },
          maxLines: 1,
          decoration: InputDecoration(
              labelText: label, labelStyle: TextStyle(fontSize: 14))),
    );
  }

  void _formSaved(String val, int index) {
    switch (index) {
      case 0:
        _provincia = val;
        break;
      case 1:
        _localidad = val;
        break;
      case 2:
        _codigoPostal = val;
        break;
      case 3:
        _nombreVia = val;
        break;
      case 4:
        _numero = val;
        break;
      case 5:
        _bloque = val;
        break;
      case 6:
        _escalera = val;
        break;
      case 7:
        _piso = val;
        break;
      case 8:
        _nombre = val;
        break;
    }
  }

  Widget _btnGuardarCambios(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 30,
          right: MediaQuery.of(context).size.width / 30),
      child: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                // No any error in validation
                _key.currentState.save();
                Direccion nuevaDireccion = new Direccion(
                    _nombre,
                    _localidad,
                    _nombreVia,
                    _provincia,
                    int.parse(_numero),
                    int.parse(_codigoPostal),
                    escalera: _escalera,
                    bloque: _bloque,
                    piso: _piso);
                widget.user.insertarDireccion(nuevaDireccion);
                Navigator.of(context).pop();
                Fluttertoast.showToast(msg: "Tus cambios se han guardado");
              } else {
                // validation error
                setState(() {
                  _validate = true;
                });
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 14,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  "Añadir dirección",
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

  Widget _nuevaDireccionPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _key,
        autovalidate: _validate,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dirección de entrega:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              _item('Provincia*', true, 0),
              _item('Localidad*', true, 1),
              _item('Codigo Postal*', true, 2),
              _item('Nombre Vía*', true, 3),
              _item('Número*', true, 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: _item('Bloque', false, 5),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _item('Escalera', false, 6),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: _item('Piso', false, 7),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Elige un nombre para esta dirección:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              _item('Nombre*', true, 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Añade una dirección'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: _nuevaDireccionPage(context),
      bottomNavigationBar: _btnGuardarCambios(context),
    );
  }
}
