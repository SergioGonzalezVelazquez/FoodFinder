import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:app_ipo/model/user_model.dart';

class LoginPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/login";
  static String logo = 'images/food-location.png';

  static Widget itemCard(BuildContext context,
          {String hint,
          IconData icono,
          bool oscureText,
          TextInputType tipoTexto,
          TextEditingController controller}) =>
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
          maxLines: 1,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(
              icono,
              color: Colors.grey,
            ),
            hintText: hint,
          ),
          obscureText: oscureText,
          keyboardType: tipoTexto,
        ),
      );

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //0xFD7555

  bool loading = false;
  bool isLogedin = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<List> sign_in(String email, String pass) async {
    setState(() {
      loading = true;
    });

    User usuario = await conectorBBDD.login(email, pass);
    if (usuario != null) {
      //Login correcto
      print('ok ' + usuario.nombre);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      //Login incorrecto
      Fluttertoast.showToast(msg: "Usuario o contraseña incorrectos");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //  isSignedIn();
  }

/*
  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await _googleSignIn.isSignedIn();

    if (isLogedin) {
      Navigator.pushReplacementNamed(context, '/home');
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    FirebaseUser firebaseUser = await _firebaseAuth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    if (firebaseUser != null) {
      //Si el usuario de Google existe, comprobamos si está registrado en nuestra BBDD
      final QuerySnapshot result = await Firestore.instance
          .collection("usuario")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        //Si el usuario no existe en nuestra bbdd...
        //insertamos el usuario en la bbdd
        Firestore.instance
            .collection("usuario")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl,
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Logged was succesful");
      setState(() {
        loading = false;
      });
    } else {}
  }
*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 1.2,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // _emailLogin(
          //   email: _email.text, password: _password.text, context: context);
          print(_emailController.text);
          sign_in(_emailController.text, _passController.text);
          //handleSignIn();
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('ENTRAR', style: TextStyle(color: Colors.white)),
      ),
    );

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
              padding: EdgeInsets.only(top: 12),
              child: Column(
                children: <Widget>[
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
                  loginButton,
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
                  ),
                  Visibility(
                    visible: loading ?? true,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.9),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
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
