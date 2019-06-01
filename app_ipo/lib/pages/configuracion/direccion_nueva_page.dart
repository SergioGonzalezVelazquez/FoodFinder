import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DireccionNuevaPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/favoritos";
  User user;
  DireccionNuevaPage(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DireccionNuevaState();
  }
}

class _DireccionNuevaState extends State<DireccionNuevaPage> {
  TextEditingController bloqueController = TextEditingController();
  TextEditingController escaleraController = TextEditingController();
  TextEditingController pisoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController provinciaController = TextEditingController();
  TextEditingController localidadController = TextEditingController();
  TextEditingController nombreViaController = TextEditingController();
  TextEditingController codigoPostalController = TextEditingController();
  TextEditingController nombreController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
    bloqueController.dispose();
    escaleraController.dispose();
    pisoController.dispose();
    numeroController.dispose();
    provinciaController.dispose();
    localidadController.dispose();
    nombreViaController.dispose();
    codigoPostalController.dispose();
    nombreController.dispose();
  }

  Widget _item(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: label, labelStyle: TextStyle(fontSize: 14))),
    );
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
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Tus cambios se han guardado");
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

  Widget _nuevaDireccionPage(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(top: 25, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dirección de entrega:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            _item('Provincia*', provinciaController),
            _item('Localidad*', localidadController),
            _item('Codigo Postal*', codigoPostalController),
            _item('Nombre Vía*', nombreViaController),
            _item('Número*', nombreViaController),
            SizedBox(
              height: 60,
            ),
            Text(
              'Elige un nombre para esta dirección:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            _item('Nombre*', nombreController),
          ],
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
