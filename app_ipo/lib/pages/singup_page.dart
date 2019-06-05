import 'package:flutter/material.dart';
import 'package:app_ipo/pages/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ipo/model/user_model.dart';
import 'package:app_ipo/pages/restaurantes/restaurantes_page.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

class SignUpPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/signup";

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _pass2Controller.dispose();
    _nombreController.dispose();
  }

  bool _validarEntradas() {
    if (_nombreController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Introduzca su nombre y apellidos");
      return false;
    }
    if (_emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Introduzca su correo electrónico");
      return false;
    }
    if (_passController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Introduzca su contraseña");
      return false;
    }
    if (_passController.text != _pass2Controller.text) {
      Fluttertoast.showToast(msg: "Las contraseñas no coinciden");
      _passController.clear();
      _pass2Controller.clear();
      return false;
    }
    return true;
  }

  _signUp(User usuario) async {
    setState(() {
      loading = true;
    });

    bool result = await ConectorBBDD.signup(usuario);
    if (result) {
      //Registro correcto
      Route ruta = new MaterialPageRoute(
          builder: (context) => new RestaurantesPage(
                usuario,
              ));
      Navigator.pushReplacement(context, ruta);
    } else {
      //Login incorrecto
      Fluttertoast.showToast(
          msg: "Ya hay un usuario registrado con ese correo electrónico");
    }

    setState(() {
      loading = false;
    });
  }

  Widget _widgetSingUp() {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      );
    } else {
      return Container(
          child: Column(children: <Widget>[
        LoginPage.itemCard(context,
            hint: 'Nombre y Apellido',
            icono: Icons.person,
            oscureText: false,
            tipoTexto: TextInputType.text,
            controller: _nombreController),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        LoginPage.itemCard(context,
            hint: 'Correo Electrónico',
            icono: Icons.email,
            oscureText: false,
            tipoTexto: TextInputType.emailAddress,
            controller: _emailController),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        LoginPage.itemCard(context,
            hint: 'Contraseña',
            icono: Icons.vpn_key,
            oscureText: true,
            tipoTexto: TextInputType.text,
            controller: _passController),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        LoginPage.itemCard(context,
            hint: 'Confirmar Contraseña',
            icono: Icons.vpn_key,
            oscureText: true,
            tipoTexto: TextInputType.text,
            controller: _pass2Controller),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        _btnRegistrar(),
        SizedBox(height: MediaQuery.of(context).size.height / 90),
        _lblIniciarSesion(),
      ]));
    }
  }

  Widget _btnRegistrar() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_validarEntradas()) {
            _signUp(new User(_nombreController.text, _emailController.text,
                password: _passController.text));
          }
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('REGISTRARSE', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _lblIniciarSesion() {
    return InkWell(
      child: Text(
        '¿Ya estás registrado? INICIAR SESIÓN',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10),
        //padding:
        //  EdgeInsets.only(top: MediaQuery.of(context).size.height / 45),
        child: new Column(
          children: <Widget>[
            LoginPage.logo(context),
            _widgetSingUp(),
          ],
        ),
      ),
    );
  }
}
