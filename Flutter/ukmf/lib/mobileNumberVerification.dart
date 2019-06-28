import 'package:flutter/material.dart';
import 'package:ukmf/appTheme.dart';
import 'package:ukmf/dropdownlist.dart';
import 'package:ukmf/referralCode.dart';

import 'mobileNumberTextField.dart';

class MobileNumberVerification extends StatefulWidget {
  _MobileNumberVerificationState createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ReferralCode(),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50.0,
                  animationDuration: Duration(seconds: 10),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text(
                    'Get OTP',
                    style: AppTheme(appTextColor: Colors.white).appTextStyle,
                  ),
                  color: AppTheme().myPrimaryMaterialColor.shade800,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50.0, 0, 0, 60.0),
                  child: CheckBoxIAgree(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CheckBoxIAgree extends StatefulWidget {
  _CheckBoxIAgreeState createState() => _CheckBoxIAgreeState();
}

class _CheckBoxIAgreeState extends State<CheckBoxIAgree> {
  double _textSize = 14.0;
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          onChanged: (bool value) {
            setState(() {
              checkBoxValue = !checkBoxValue;
            });
          },
          value: checkBoxValue,
        ),
        Text(
          'I agree to ',
          style: AppTheme(appTextFontSize: _textSize).appTextStyle,
        ),
        Text(
          'Terms & Conditions',
          style:
              AppTheme(isLink: true, appTextFontSize: _textSize).appTextStyle,
        )
      ],
    );
  }
}
