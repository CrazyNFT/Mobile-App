import 'package:flutter/material.dart';
import 'package:mobile_app/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = const {
      50: Color.fromRGBO(28, 129, 124, .1),
      100: Color.fromRGBO(28, 129, 124, .2),
      200: Color.fromRGBO(28, 129, 124, .3),
      300: Color.fromRGBO(28, 129, 124, .4),
      400: Color.fromRGBO(28, 129, 124, .5),
      500: Color.fromRGBO(28, 129, 124, .6),
      600: Color.fromRGBO(28, 129, 124, .7),
      700: Color.fromRGBO(28, 129, 124, .8),
      800: Color.fromRGBO(28, 129, 124, .9),
      900: Color.fromRGBO(28, 129, 124, 1),
    };

    MaterialColor primaryColor = MaterialColor(0xff1c817c, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: primaryColor),
      home: const LoginPage(),
    );
  }
}
