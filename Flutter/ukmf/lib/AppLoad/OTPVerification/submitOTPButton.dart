import '../../appTheme.dart';

import 'package:ukmf/AppLoad/OTPVerification/resendOTP.dart';
import 'package:flutter/material.dart';

class PostRequest {
  final String source, templateName, phoneNumber, language;

  PostRequest(
      {this.source, this.templateName, this.phoneNumber, this.language});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
      source: json['source'],
      templateName: json['templateName'],
      phoneNumber: json['phoneNumber'],
      language: json['language'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["source"] = source;
    map["templateName"] = templateName;
    map["phoneNumber"] = phoneNumber;
    map["language"] = language;

    return map;
  }
}

class SutmitOTP extends StatelessWidget {
  final String mobileNumber, otp;
  SutmitOTP({this.mobileNumber = '', this.otp = ''});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        MaterialButton(
          color: AppTheme().myPrimaryMaterialColor.shade800,
          height: 50.0,
          disabledColor: Colors.grey,
          minWidth: double.infinity,
          child: Text('Submit OTP',
              style: AppTheme(appTextColor: Colors.white).appTextStyle),
          onPressed: () {},
        ),
        ResendOTP()
      ]),
    );
  }
}
