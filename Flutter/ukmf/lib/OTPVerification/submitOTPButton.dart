import 'package:provider/provider.dart';
import 'package:ukmf/OTPVerification/otpVerificationScheduler.dart';
import 'package:ukmf/signUp/signup.dart';

import '../appTheme.dart';

import 'resendOTP.dart';
import 'package:flutter/material.dart';

class SutmitOTP extends StatelessWidget {
  final String mobileNumber, otp;
  SutmitOTP({this.mobileNumber = '', this.otp = ''});

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
                  if (otpVerificationScheduler.otp == '') {
                    otpVerificationScheduler.otp = otp;
                  }
                  if (otpVerificationScheduler.mobileNumber == '') {
                    otpVerificationScheduler.mobileNumber = mobileNumber;
                  }

                  print('Current otp ${otpVerificationScheduler.otp}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
              ),
              ResendOTP()
            ]),
          ),
    );
  }
}
