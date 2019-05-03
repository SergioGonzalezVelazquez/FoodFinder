import 'package:flutter/material.dart';

class PlatosPage extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Platos"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Widget de platos..."),
        ),
      ),
    );
  }
}