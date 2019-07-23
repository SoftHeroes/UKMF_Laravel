import '../setup.dart';
import '../appTheme.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'otpVerificationScheduler.dart';

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

class ResendOTP extends StatelessWidget {
  final String otp, mobileNumber;

  ResendOTP({this.otp = '', this.mobileNumber = ''});

  final Setup setupRef = Setup();

  @override
  Widget build(BuildContext context) {
    PostRequest newRequest;

    return Consumer<OTPVerificationScheduler>(
      builder: (context, otpVerificationSchedulerConsumerRef, _) {
        getResponse(OTPVerificationScheduler otpVerificationScheduler,
            {Map requestBody}) async {
          otpVerificationScheduler.isResendingOTP = true;
          var resposne =
              await post(setupRef.server + setupRef.smsSent, body: requestBody);
          otpVerificationSchedulerConsumerRef.isResendingOTP = false;
          otpVerificationSchedulerConsumerRef.response = resposne;
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 60.0),
          child: GestureDetector(
            onTap: () {
              if (otpVerificationSchedulerConsumerRef.isCanResendOTP) {
                if (otpVerificationSchedulerConsumerRef.mobileNumber == '') {
                  otpVerificationSchedulerConsumerRef.mobileNumber =
                      mobileNumber;
                }
                if (otpVerificationSchedulerConsumerRef.otp == '') {
                  otpVerificationSchedulerConsumerRef.otp = otp;
                }

                newRequest = new PostRequest(
                    source: setupRef.source,
                    templateName: "OTP",
                    phoneNumber:
                        otpVerificationSchedulerConsumerRef.mobileNumber,
                    language: setupRef.language);

                getResponse(otpVerificationSchedulerConsumerRef,
                    requestBody: newRequest.toMap());
              }
            },
            child: Text(
              'Resend OTP',
              style: AppTheme(
                      isLink:
                          otpVerificationSchedulerConsumerRef.isCanResendOTP,
                      appTextColor: Colors.grey)
                  .appTextStyle,
            ),
          ),
        );
      },
    );
  }
}
