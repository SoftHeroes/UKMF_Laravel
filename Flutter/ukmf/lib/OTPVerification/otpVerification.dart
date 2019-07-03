import '../appTheme.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'OTPField.dart';
import 'OTPLoader.dart';

class OTPVerificationForm extends StatefulWidget {
  OTPVerificationForm({Key key}) : super(key: key);

  _OTPVerificationFormState createState() => _OTPVerificationFormState();
}

class _OTPVerificationFormState extends State<OTPVerificationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          child: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Text(
              'Enter your OTP below',
              style: AppTheme(
                appTextFontSize: 24,
                appfontWeight: FontWeight.bold,
              ).appTextStyle,
            ),
            SizedBox(
              height: 60.0,
            ),
            OTPValue(
              count: 6,
            ),
            SizedBox(
              height: 60.0,
            ),
            OTPLoader(),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      'SUBMIT',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
