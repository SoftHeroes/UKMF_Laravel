import 'package:flutter/material.dart';
import 'package:ukmf/appTheme.dart';
import 'package:ukmf/dropdownlist.dart';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 33.0, 0, 0),
            child: Text(
              'Got a referral code ?',
              style: AppTheme(isLink: true).appTextStyle,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 50, minWidth: double.maxFinite),
                child: MaterialButton(
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
              ),
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          onChanged: (bool value) {},
          value: false,
        ),
        Text(
          'I agree to',
          style: AppTheme().appTextStyle,
        ),
        Text(
          'I agree to',
          style: AppTheme(isLink: true).appTextStyle,
        )
      ],
    );
  }
}
