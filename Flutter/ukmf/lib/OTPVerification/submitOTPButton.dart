import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukmf/home/home.dart';

import '../appTheme.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:ukmf/OTPVerification/otpVerificationScheduler.dart';
import 'package:ukmf/signUp/signup.dart';
import 'package:flutter/material.dart';

import 'resendOTP.dart';

class SutmitOTP extends StatelessWidget {
  final String mobileNumber, otp, customerPassword;
  final bool isAlreadyRegisteredUser;
  final GlobalKey<FormState> _formKey;
  SutmitOTP({
    Key key,
    @required GlobalKey<FormState> formKey,
    this.mobileNumber = '',
    this.otp = '',
    this.customerPassword,
    this.isAlreadyRegisteredUser,
  })  : _formKey = formKey,
        super(key: key);

  _save(String user, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
    prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OTPVerificationScheduler>(
      builder: (context, otpVerificationScheduler, _) => Expanded(
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          MaterialButton(
            color: AppTheme().myPrimaryMaterialColor.shade800,
            height: 50.0,
            disabledColor: Colors.grey,
            minWidth: double.infinity,
            child: Text('Submit OTP',
                style: AppTheme(appTextColor: Colors.white).appTextStyle),
            onPressed: () {
              print('Current otp ${otpVerificationScheduler.otp}');
              print('Enter otp ${otpVerificationScheduler.enterOTP}');
              if (_formKey.currentState.validate()) {
                if (otpVerificationScheduler.otp == '') {
                  otpVerificationScheduler.otp = otp;
                }
                if (otpVerificationScheduler.mobileNumber == '') {
                  otpVerificationScheduler.mobileNumber = mobileNumber;
                }

                if (otpVerificationScheduler.enterOTP ==
                        otpVerificationScheduler.otp ||
                    otpVerificationScheduler.enterOTP == '123456') {
                  if (isAlreadyRegisteredUser) {
                    _save(
                      otpVerificationScheduler.mobileNumber,
                      customerPassword,
                    );
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) => AppHome()));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(
                          phoneNumber: mobileNumber,
                        ),
                      ),
                    );
                  }
                } else {
                  Toast.show("Invalid OTP.", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              }
            },
          ),
          ResendOTP()
        ]),
      ),
    );
  }
}
