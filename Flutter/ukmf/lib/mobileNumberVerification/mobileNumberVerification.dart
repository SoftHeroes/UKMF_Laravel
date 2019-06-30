import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dropdownlist.dart';
import 'mobileNumberVerificationScheduler.dart';
import 'referralCode.dart';
import 'checkBoxIAgree.dart';
import 'getOTPButton.dart';
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
      child: ChangeNotifierProvider(
        builder: (context) => MobileNumberVerificationScheduler(),
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
                  GetOTPButton(formKey: _formKey),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 0, 0, 60.0),
                    child: CheckBoxIAgree(),
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
