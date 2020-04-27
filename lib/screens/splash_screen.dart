import 'package:flutter/material.dart';
import 'package:halls_city/screens/home_screen.dart';
import 'package:halls_city/services/halls_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import '../Constants.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String lT = 'Welcome to Halls City';
  HallsData _hallsData;
//  bool status = false;
//  void navigateUser() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    this.status = prefs.getBool('isLoggedIn') ?? false;
//    print('labla$status');
//  }

  @override
  Widget build(BuildContext context) {
    _hallsData = HallsData();
    _hallsData.getAllHalls();
    return SplashScreen(
      backgroundColor: main_light_color,
      title: Text(
        'Halls City',
        style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: main_dark_color,
            fontFamily: 'Ballegra'),
      ),
      photoSize: 88.0,
      image: lightLogo,
      loadingText: Text(
        lT,
        style: TextStyle(fontSize: 11.0, color: main_dark_color),
      ),
      seconds: 5,
      navigateAfterSeconds: LoginScreen(),
      loaderColor: light_gray_color,
      //this will be a method
    );
  }
}
