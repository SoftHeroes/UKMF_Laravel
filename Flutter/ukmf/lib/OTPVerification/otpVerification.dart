import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../appTheme.dart';

import 'package:flutter/material.dart';

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
        child: Center(
          child: Container(
            width: 40,
            height: 58,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'X',
                    hintStyle:
                        AppTheme(appTextFontSize: 36, appTextColor: Colors.grey)
                            .appTextStyle,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  style: AppTheme(appTextFontSize: 36).appTextStyle,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 3,
                    color: AppTheme().myPrimaryMaterialColor.shade200)),
          ),
        ),
      ),
    );
  }
}
