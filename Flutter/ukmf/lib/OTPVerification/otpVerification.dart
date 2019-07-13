import 'package:provider/provider.dart';

import '../appTheme.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'OTPLoader.dart';
import 'OTPField.dart';
import 'otpVerificationScheduler.dart';
import 'submitOTPButton.dart';

class OTPVerificationForm extends StatefulWidget {
  final String mobileNumber, otp, countryCode;

  OTPVerificationForm({
    Key key,
    this.countryCode = '',
    this.mobileNumber = '',
    this.otp = '',
  }) : super(key: key);

  _OTPVerificationFormState createState() => _OTPVerificationFormState();
}

class _OTPVerificationFormState extends State<OTPVerificationForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify ' + widget.countryCode + ' ' + widget.mobileNumber,
          style: AppTheme(appTextColor: Colors.white).appTextStyle,
        ),
        backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          child: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => OTPVerificationScheduler(),
        child: Form(
          key: _formKey,
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
              OTPField(
                formKey: _formKey,
              ),
              SizedBox(
                height: 60.0,
              ),
              OTPLoader(),
              SutmitOTP(
                otp: widget.otp,
                mobileNumber: widget.mobileNumber,
                formKey: _formKey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
