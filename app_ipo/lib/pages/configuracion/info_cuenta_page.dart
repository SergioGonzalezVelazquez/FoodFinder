import 'package:flutter/material.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoCuentaPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/favoritos";
  final User user;
  InfoCuentaPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return _InfoCuentaState();
  }
}

class _InfoCuentaState extends State<InfoCuentaPage> {
  bool _isButtonDisabled;

  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _isButtonDisabled = true;

    if (widget.user.nombre != null) {
      nombreController.text = widget.user.nombre;
    }
    if (widget.user.email != null) {
      emailController.text = widget.user.email;
    }
    if (widget.user.password != null) {
      passController.text = widget.user.password;
    }
    if (widget.user.telefono != null) {
      telefonoController.text = widget.user.telefono;
    }

    nombreController.addListener(_listenerController);
    emailController.addListener(_listenerController);
    passController.addListener(_listenerController);
    telefonoController.addListener(_listenerController);
  }

  void _listenerController() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  void dispose() {
    super.dispose();
    nombreController.dispose();
    emailController.dispose();
    passController.dispose();
    telefonoController.dispose();
  }

  Widget _item(String label, IconData icono, TextEditingController controller,
      {bool oscureText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
          controller: controller,
          obscureText: oscureText == null ? false : oscureText,
          decoration: InputDecoration(labelText: label, icon: Icon(icono))),
    );
  }

  Widget _btnGuardarCambios(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _isButtonDisabled
          ? null
          : () {
              widget.user.updateUser(
                  nombreController.text,
                  emailController.text,
                  passController.text,
                  telefonoController.text);
              Navigator.of(context).pop();
              Fluttertoast.showToast(msg: "Tus cambios se han guardado");
            },
      child: Center(
        child: Text(
          "Guardar cambios",
          style: TextStyle(
            color: _isButtonDisabled ? Colors.black : Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _infoCuentaPage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _item('Nombre', Icons.person, nombreController),
          _item('E-Mail', Icons.mail, emailController),
          _item('Contraseña', Icons.vpn_key, passController, oscureText: true),
          _item('Número de teléfono', Icons.phone, telefonoController),
          SizedBox(
            height: 40,
          ),
          _btnGuardarCambios(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        //elevation: 0.0, //Quitar sombra de la appBar
        title: new Text('Información de la cuenta'),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: _infoCuentaPage(context),
    );
  }
}
