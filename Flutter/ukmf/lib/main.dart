import 'package:ukmf/signUp/signup.dart';

import './appTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mobileNumberVerification/mobileNumberVerification.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppTheme().myPrimaryMaterialColor),
      // home: SignUp(),
      home: MobileNumberVerification(),
    );
  }
}
