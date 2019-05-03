import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget{
  //Variable estática que se utiliza en routes.dart
  static const nombreRuta = "/signup";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to SingUp'),
      ),
      body:Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
           TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          RaisedButton(
            child: Text('SignUp'),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/login');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}