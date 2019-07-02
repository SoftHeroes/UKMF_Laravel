import './appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './mobileNumberVerification/mobileNumberVerification.dart';
import 'OTPVerification/otpVerification.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppTheme().myPrimaryMaterialColor),
      home: (1 == 1) ? OTPVerificationForm() : MobileNumberVerification(),
    );
  }
}
