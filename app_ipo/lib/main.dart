import 'package:flutter/material.dart';

import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _appName = 'Food Finder';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: new ThemeData(
          primaryColor: new Color(0xffFD7555),
          accentColor: new Color(0xffC4442A)),
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
    );
  }
}
