import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halls_city/screens/adding_hall_screen.dart';
import 'package:halls_city/screens/home_screen.dart';
import 'package:halls_city/screens/location_screen(Empty).dart';
import 'package:halls_city/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This widget is the root of the application.
    return MaterialApp(
      //removing debug mode bunner
      debugShowCheckedModeBanner: false,
      //calling [HomeScreen] constructor as a home page
      home: Splash(),
    );
  }
}
