import 'dart:convert';

import 'package:http/http.dart';
import 'package:ukmf/OTPVerification/otpVerification.dart';

import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

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

  List<Widget> _buildForm(
    BuildContext context,
    MobileNumberVerificationScheduler mobileNumberVerificationScheduler,
  ) {
    Form form = Form(
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
    );

    var pagelist = new List<Widget>();
    pagelist.add(form);

    if (mobileNumberVerificationScheduler.saving) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      pagelist.add(modal);
    }
    Response response = mobileNumberVerificationScheduler.response;
    mobileNumberVerificationScheduler.response = null;
    if (mobileNumberVerificationScheduler.isGetOTPCalled && response != null) {
      mobileNumberVerificationScheduler.isGetOTPCalled = false;
      if (response.statusCode == HttpStatus.ok) {
        if (json.decode(response.body)["ErrorFound"] == "NO") {
          print('call to new page');

          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerificationForm(
                  mobileNumber: mobileNumberVerificationScheduler.mobileNumber,
                  otp: json.decode(response.body)["OTP"],
                  countryCode: mobileNumberVerificationScheduler.countryCode,
                ),
              ),
            ),
          );

          ;
        }
      }
    }

    return pagelist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
      ),
      body: ChangeNotifierProvider(
        builder: (context) => MobileNumberVerificationScheduler(),
        child: Consumer<MobileNumberVerificationScheduler>(
          builder: (context, mobileNumberVerificationScheduler, _) => Stack(
            children: _buildForm(context, mobileNumberVerificationScheduler),
          ),
        ),
      ),
    );
  }
}
