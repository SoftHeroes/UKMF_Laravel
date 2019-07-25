import '../setup.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String user;
  String password;
  final Setup setupRef = Setup();

  _read() async {
    final prefs = await SharedPreferences.getInstance();

    user = prefs.getString('user') ?? null;
    password = prefs.getString('password') ?? null;
    print('read: user : $user password : $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500.0,
          width: 500.0,
          child: Image.asset('assets/companyLogo.png'),
        ),
      ),
    );
  }
}
