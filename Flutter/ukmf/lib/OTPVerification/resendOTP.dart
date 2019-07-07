import '../setup.dart';
import '../appTheme.dart';

import 'package:async_loader/async_loader.dart';
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
  final GlobalKey<AsyncLoaderState> _asyncKey =
      new GlobalKey<AsyncLoaderState>();

  final Setup setupRef = Setup();

  getResponse({Map requestBody}) async {
    // return Future.delayed(Duration(seconds: 50));
    return post(setupRef.server + setupRef.smsSent, body: requestBody);
  }

  @override
  Widget build(BuildContext context) {
    PostRequest newRequest;
    var _asyncLoader = new AsyncLoader(
      key: _asyncKey,
      initState: () async => await getResponse(requestBody: newRequest.toMap()),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => Text(
            'Resend OTP',
            style:
                AppTheme(isLink: true, appTextColor: Colors.grey).appTextStyle,
          ),
      renderSuccess: ({data}) {
        print('It end!');
        return Text(
          'Resend OTP',
          style:
              AppTheme(isLink: false, appTextColor: Colors.grey).appTextStyle,
        );
      },
    );

    return Consumer<OTPVerificationScheduler>(
      builder: (context, otpVerificationScheduler, _) => Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 60.0),
            child: GestureDetector(
              onTap: () {
                if (otpVerificationScheduler.isCanResendOTP) {
                  _asyncKey.currentState
                      .reloadState()
                      .whenComplete(() => print('finished reload'));
                  otpVerificationScheduler.isShowingLoader = true;
                }
              },
              child: _asyncLoader,
              // Text(
              //   'Resend OTP',
              //   style: AppTheme(
              //           isLink: otpVerificationScheduler.isCanResendOTP,
              //           appTextColor: Colors.grey)
              //       .appTextStyle,
              // )
              // ,
            ),
          ),
    );
  }
}
