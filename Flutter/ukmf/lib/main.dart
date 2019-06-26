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
      theme: ThemeData(primarySwatch: AppTheme().myPrimaryGreen),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme().myPrimaryGreen.shade500,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              DropDownList(
                ['+91', '+12', '+98', '+45', '+65'],
                dropDownDefaultValue: '+91',
              ),
              SizedBox(
                width: 20.0,
              ),
              MobileNumberTextField(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    onPressed: () => {},
                    child: Text('Get OTP'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
