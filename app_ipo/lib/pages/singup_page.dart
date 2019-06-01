import 'package:flutter/material.dart';
import 'package:app_ipo/pages/login_page.dart';

class SignUpPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/signup";

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      LoginPage.logo,
                      scale: 3,
                      alignment: Alignment.center,
                    ),
                    Text(
                      'Food Finder',
                      style: new TextStyle(fontSize: 30.0),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    LoginPage.itemCard(context,
                        hint: 'Nombre y Apellido',
                        icono: Icons.person,
                        oscureText: false,
                        tipoTexto: TextInputType.text,
                        controller: _nombreController),
                    LoginPage.itemCard(context,
                        hint: 'Correo Electrónico',
                        icono: Icons.email,
                        oscureText: false,
                        tipoTexto: TextInputType.emailAddress,
                        controller: _emailController),
                    LoginPage.itemCard(context,
                        hint: 'Contraseña',
                        icono: Icons.vpn_key,
                        oscureText: true,
                        tipoTexto: TextInputType.text,
                        controller: _passController),
                    LoginPage.itemCard(context,
                        hint: 'Confirmar Contraseña',
                        icono: Icons.vpn_key,
                        oscureText: true,
                        tipoTexto: TextInputType.text,
                        controller: _pass2Controller),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 28),
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color.fromRGBO(253, 117, 85, 1),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: FlatButton(
                        child: Text(
                          'REGISTRARSE',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.transparent,
                        onPressed: () {
                          print("Has presionado el botón de registrar");
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
