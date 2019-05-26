import 'package:flutter/material.dart';
import 'package:app_ipo/pages/login_page.dart';

class SignUpPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/signup";

  Widget build(BuildContext context) {
    // TODO: implement build
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
                    //LoginPage.itemCard(context, 'Nombre y Apellido',
                      //  Icons.person, false, TextInputType.text),
                    //LoginPage.itemCard(context, 'Correo Electrónico',
                      //  Icons.email, false, TextInputType.emailAddress),
                    //LoginPage.itemCard(context, 'Contraseña', Icons.vpn_key,
                      //  true, TextInputType.text),
                    //LoginPage.itemCard(context, 'Confirmar Contraseña',
                      //  Icons.vpn_key, true, TextInputType.text),
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
