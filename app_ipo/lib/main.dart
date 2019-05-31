import 'package:flutter/material.dart';

import 'routes.dart';

void main() => runApp(MyApp());

//#fd7555 -- Primary
//#ffa682 -- Ligth
//#c4442a -- Dark

// GRISES
//#FAFAFA -- Primary
//#c7c7c7-- Dark


class MyApp extends StatelessWidget {
  final String _appName = 'Food Finder';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: new ThemeData(
        primaryColor: new Color(0xffFD7555),
        accentColor: new Color(0xffC4442A)
        //accentColor: new Color(0xff8D8D8D)
      ),
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
    );
  }
}
