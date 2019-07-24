import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

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

  List<Widget> _buildForm(
    BuildContext context,
    OTPVerificationScheduler otpVerificationScheduler,
  ) {
    Form form = Form(
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
    );

    var pagelist = new List<Widget>();
    pagelist.add(form);

    if (otpVerificationScheduler.isResendingOTP) {
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (otpVerificationScheduler.isResendingOTPCompleted) {
          otpVerificationScheduler.isResendingOTPCompleted = false;
          Response response = otpVerificationScheduler.response;
          otpVerificationScheduler.response = null;

          if (response != null) {
            if (response.statusCode != HttpStatus.ok) {
              Toast.show("Unable to send SMS", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            } else {
              dynamic jsonData = json.decode(response.body);

              if (jsonData["ErrorFound"] == "NO") {
                otpVerificationScheduler.isShowingLoader = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationForm(
                      mobileNumber: otpVerificationScheduler.mobileNumber,
                      otp: jsonData["OTP"],
                      countryCode: otpVerificationScheduler.countryCode,
                    ),
                  ),
                );
              } else {
                Toast.show("Unable to send SMS", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            }
          }
        }
      },
    );

    return pagelist;
  }

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
        child: Consumer<OTPVerificationScheduler>(
          builder: (context, mobileNumberVerificationScheduler, _) => Stack(
            children: _buildForm(context, mobileNumberVerificationScheduler),
          ),
        ),
      ),
    );
  }
}
