import '../appTheme.dart';
import '../setup.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'mobileNumberVerificationScheduler.dart';

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

class GetOTPButton extends StatelessWidget {
  GetOTPButton({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Setup setupRef = Setup();

  @override
  Widget build(BuildContext context) {
    PostRequest newRequest;

    getResponse(
        MobileNumberVerificationScheduler mobileNumberVerificationScheduler,
        {Map requestBody,
        BuildContext context}) async {
      mobileNumberVerificationScheduler.isGettingOTP = true;
      var resposne =
          await post(setupRef.server + setupRef.smsSent, body: requestBody);

      mobileNumberVerificationScheduler.isGettingOTP = false;
      mobileNumberVerificationScheduler.isGettingOTPCompleted = true;
      mobileNumberVerificationScheduler.response = resposne;
    }

    return Consumer<MobileNumberVerificationScheduler>(
      builder: (context, mobileNumberVerificationScheduler, _) =>
          MaterialButton(
        disabledColor: Colors.grey,
        minWidth: double.infinity,
        height: 50.0,
        animationDuration: Duration(seconds: 10),
        onPressed: !mobileNumberVerificationScheduler.isIAgree
            ? null
            : () {
                if (_formKey.currentState.validate()) {
                  newRequest = new PostRequest(
                      source: setupRef.source,
                      templateName: "OTP",
                      phoneNumber:
                          mobileNumberVerificationScheduler.mobileNumber,
                      language: setupRef.language);

                  getResponse(mobileNumberVerificationScheduler,
                      requestBody: newRequest.toMap());
                }
              },
        child: Text(
          'Get OTP',
          style: AppTheme(appTextColor: Colors.white).appTextStyle,
        ),
        color: AppTheme().myPrimaryMaterialColor.shade800,
      ),
    );
  }
}
