import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './appTheme.dart';
import './mobileNumberTextField.dart';
import './dropdownlist.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppTheme().myPrimaryMaterialColor),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(24.0, 64.0, 0, 0),
              child: Row(
                children: <Widget>[
                  DropDownList(
                    [
                      '+91',
                      '+12',
                      '+98',
                      '+45',
                      '+65',
                      '+68',
                      '+55',
                      '+56',
                      '+57',
                      '+58'
                    ],
                    dropDownDefaultValue: '+91',
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  MobileNumberTextField()
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  constraints:
                      BoxConstraints(minHeight: 50, minWidth: double.maxFinite),
                  child: MaterialButton(
                    animationDuration: Duration(seconds: 10),
                    onPressed: () {},
                    child: Text(
                      'Get OTP',
                      style: AppTheme(appTextColor: Colors.white).appTextStyle,
                    ),
                    color: AppTheme().myPrimaryMaterialColor.shade800,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
