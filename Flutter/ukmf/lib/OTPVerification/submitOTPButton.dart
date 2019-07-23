import '../appTheme.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:ukmf/OTPVerification/otpVerificationScheduler.dart';
import 'package:ukmf/signUp/signup.dart';
import 'package:flutter/material.dart';

import 'resendOTP.dart';

class SutmitOTP extends StatelessWidget {
  final String mobileNumber, otp;

  final GlobalKey<FormState> _formKey;
  SutmitOTP(
      {Key key,
      @required GlobalKey<FormState> formKey,
      this.mobileNumber = '',
      this.otp = ''})
      : _formKey = formKey,
        super(key: key);

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
                    otpVerificationScheduler.otp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
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
