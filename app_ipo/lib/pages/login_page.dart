import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_ipo/data/gestorBBDD.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ipo/pages/restaurantes/restaurantes_page.dart';
import 'package:app_ipo/custom_icons_icons.dart';
import 'package:app_ipo/model/user_model.dart';

class LoginPage extends StatefulWidget {
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/login";
  static String imageLogo = 'images/food-location.png';

  //Widget con logo utilizado en login y registro
  static Widget logo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            LoginPage.imageLogo,
            scale: 3,
            alignment: Alignment.center,
          ),
          Text(
            'Food Finder',
            style: new TextStyle(fontSize: 30.0),
          )
        ],
      ),
    );
  }

  //Widget con entrada de texto utilizado en login y registro
  static Widget itemCard(BuildContext context,
      {String hint,
      IconData icono,
      bool oscureText,
      TextInputType tipoTexto,
      TextEditingController controller}) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
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
  }

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //0xFD7555

  bool loading = false;
  bool isLogedin = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  signIn(String email, String pass) async {
    setState(() {
      loading = true;
    });
    User usuario = await ConectorBBDD.login(email, pass);
    if (usuario != null) {
      //Login correcto
      Route ruta = new MaterialPageRoute(
          builder: (context) => new RestaurantesPage(
                usuario,
              ));
      Navigator.pushReplacement(context, ruta);
    } else {
      //Login incorrecto
      Fluttertoast.showToast(msg: "Usuario o contraseña incorrectos");
    }
    setState(() {
      loading = false;
    });
  }

  Future signInGoogle() async {
    setState(() {
      loading = true;
    });
    User usuario = await ConectorBBDD.loginGoogle();
    if (usuario != null) {
      //Login correcto
      Route ruta = new MaterialPageRoute(
          builder: (context) => new RestaurantesPage(
                usuario,
              ));
      Navigator.pushReplacement(context, ruta);
    } else {
      //Login incorrecto
      Fluttertoast.showToast(
          msg: "Error. No se pudo iniciar sesión con Google");
    }

    setState(() {
      loading = false;
    });
  }

  Widget _btnLogin() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_emailController.text.trim().isEmpty ||
              _passController.text.trim().isEmpty) {
            Fluttertoast.showToast(
                msg:
                    "Introduzca su dirección de correo electrónico y contraseña");
          } else {
            signIn(_emailController.text.trim(), _passController.text);
          }
        },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('ENTRAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _widgetLogin() {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
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
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "Funcionalidad no implementada... :(");
                },
                child: Text(
                  '¿Has olvidado tu contraseña?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            _btnLogin(),
            SizedBox(height: MediaQuery.of(context).size.height / 100),
            _lblRegistrar(),
          ],
        ),
      );
    }
  }

  Widget _loginSocial() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _lblSocialLogin(),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Facebook
              _socialIcon(
                colors: [
                  Color(0xFF102397),
                  Color(0xFF187adf),
                  Color(0xFF00eaf8),
                ],
                iconData: CustomIcons.facebook,
              ),
              //Google
              _socialIcon(
                  colors: [
                    Color(0xFFff4f38),
                    Color(0xFFff355d),
                  ],
                  iconData: CustomIcons.google,
                  onPressed: () {
                    signInGoogle();
                  }),
              //twitter
              _socialIcon(
                colors: [
                  Color(0xFF17ead9),
                  Color(0xFF6078ea),
                ],
                iconData: CustomIcons.twitter,
              ),
              //linkedin
              _socialIcon(
                colors: [
                  Color(0xFF00c6fb),
                  Color(0xFF005bea),
                ],
                iconData: CustomIcons.linkedin,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(
      {List<Color> colors, IconData iconData, Function onPressed}) {
    return new Padding(
      padding: EdgeInsets.only(left: 14.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp)),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: (onPressed != null)
              ? onPressed
              : () {
                  Fluttertoast.showToast(
                      msg: "Funcionalidad no implementada... :(");
                },
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }

  Widget _lblSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Horizontal line
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: 1.0,
              color: Colors.black26.withOpacity(.2),
            )),
        Text(
          'O',
          style: TextStyle(color: Colors.grey),
        ),
        //Horizontal line
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: 1.0,
              color: Colors.black26.withOpacity(.2),
            )),
      ],
    );
  }

  Widget _lblRegistrar() {
    return InkWell(
      child: Text(
        '¿Aún no tienes cuenta? REGÍSTRATE',
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/signup');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: 10, horizontal: MediaQuery.of(context).size.width / 10),
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 45),
        child: new Column(
          children: <Widget>[
            LoginPage.logo(context),
            _widgetLogin(),
          ],
        ),
      ),
      bottomNavigationBar: _loginSocial(),
    );
  }
}
