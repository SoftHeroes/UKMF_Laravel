import 'package:ukmf/signUp/signup.dart';
import 'package:ukmf/signUp/signup_test.dart';

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
      home: SignUpTest(),
      // home: MobileNumberVerification(),
    );
  }
}
