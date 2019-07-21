import 'dart:convert';
import 'dart:io';

import '../setup.dart';
import '../appTheme.dart';

import 'package:async_loader/async_loader.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

  final GlobalKey<AsyncLoaderState> _asyncKey =
      new GlobalKey<AsyncLoaderState>();
  final Setup setupRef = Setup();

  @override
  Widget build(BuildContext context) {
    PostRequest newRequest;

    return Consumer<OTPVerificationScheduler>(
      builder: (context, otpVerificationSchedulerConsumerRef, _) {
        getResponse({Map requestBody}) async {
          var resposne =
              await post(setupRef.server + setupRef.smsSent, body: requestBody);

          if (resposne.statusCode == HttpStatus.ok) {
            json.decode(resposne.body);
            if (json.decode(resposne.body)["ErrorFound"] == "NO") {
              otpVerificationSchedulerConsumerRef.isShowingLoader = true;
              otpVerificationSchedulerConsumerRef.otp =
                  json.decode(resposne.body)["OTP"];
            }
          }

          return resposne;
        }

        var _asyncLoader = new AsyncLoader(
          key: _asyncKey,
          initState: () async => getResponse(requestBody: newRequest.toMap()),
          renderLoad: () => new CircularProgressIndicator(),
          renderError: ([error]) {
            return Text(
              'Resend OTP',
              style: AppTheme(
                      isLink:
                          otpVerificationSchedulerConsumerRef.isCanResendOTP,
                      appTextColor: Colors.grey)
                  .appTextStyle,
            );
          },
          renderSuccess: ({data}) {
            Response resposne = data;

            if (resposne.statusCode != HttpStatus.ok ||
                json.decode(resposne.body)["ErrorFound"] == "YES") {
              Toast.show("unable to send message", context,
                  duration: 1, gravity: Toast.BOTTOM);
            }

            return Text(
              'Resend OTP',
              style: AppTheme(
                      isLink:
                          otpVerificationSchedulerConsumerRef.isCanResendOTP,
                      appTextColor: Colors.grey)
                  .appTextStyle,
            );
          },
        );

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
                _asyncKey.currentState
                    .reloadState()
                    .whenComplete(() => print('finished reload'));
              }
            },
            child: _asyncLoader,
          ),
        );
      },
    );
  }
}
