import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/login";
  static String logo = 'images/food-location.png';

  static Widget itemCard(BuildContext context, String hint, IconData icono, bool pass,
          TextInputType tipoTexto) =>
      Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 45,
        margin: EdgeInsets.only(top: 22),
        padding: EdgeInsets.only(
            top: 4,
            left: 16,
            right: 16,
            bottom: 4), //Padding texto dentro de la caja
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icono,
              color: Colors.grey,
            ),
            hintText: hint,
          ),
          obscureText: pass,
          keyboardType: tipoTexto,
        ),
      );
  //0xFD7555
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
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
                    logo,
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
              padding: EdgeInsets.only(top: 12),
              child: Column(
                children: <Widget>[
                  itemCard(context, 'Correo Electrónico', Icons.email, false,
                      TextInputType.emailAddress),
                  itemCard(context, 'Contraseña', Icons.vpn_key, true,
                      TextInputType.text),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        '¿Has olvidado tu contraseña?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 52),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color.fromRGBO(253, 117, 85, 1),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: FlatButton(
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      textColor: Colors.white,
                      color: Colors.transparent,
                      onPressed: () {
                        print("Has presionado el botón de entrar");
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: FlatButton(
                            child: Text(
                              '¿Aún no tienes cuenta? REGÍSTRATE',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.grey,
                            color: Colors.transparent,
                            onPressed: () {
                              print("Has presionado el botón de registrase");
                              Navigator.pushNamed(context, '/signup');
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
