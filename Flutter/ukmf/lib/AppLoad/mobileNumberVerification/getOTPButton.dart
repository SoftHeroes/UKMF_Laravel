import 'package:ukmf/AppLoad/userDetailsProvider.dart';

import '../../appTheme.dart';
import '../../setup.dart';

import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

import 'package:ukmf/AppLoad/OTPVerification/otpVerification.dart';
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
  final GlobalKey<AsyncLoaderState> _asyncKey =
      new GlobalKey<AsyncLoaderState>();

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

    getResponse({Map requestBody, BuildContext context}) async {
      var resposne =
          await post(setupRef.server + setupRef.smsSent, body: requestBody);

      if (resposne.statusCode == HttpStatus.ok) {
        json.decode(resposne.body);
        if (json.decode(resposne.body)["ErrorFound"] == "NO") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OTPVerificationForm()));
        }
      }
      return resposne;
    }

    var _asyncLoader = new AsyncLoader(
      key: _asyncKey,
      initState: () async =>
          getResponse(requestBody: newRequest.toMap(), context: context),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => Text(
            'Get OTP',
            style: AppTheme(appTextColor: Colors.white).appTextStyle,
          ),
      renderSuccess: ({data}) {
        print('It end!');
        return Text(
          'Get OTP',
          style: AppTheme(appTextColor: Colors.white).appTextStyle,
        );
      },
    );

    return Consumer<MobileNumberVerificationScheduler>(
      builder: (context, mobileNumberVerificationScheduler, _) =>
          Consumer<UserDetailsProvider>(
            builder: (context, userDetailsProvider, _) => MaterialButton(
                  disabledColor: Colors.grey,
                  minWidth: double.infinity,
                  height: 50.0,
                  animationDuration: Duration(seconds: 10),
                  onPressed: !mobileNumberVerificationScheduler.isIAgree
                      ? null
                      : () {
                          if (_formKey.currentState.validate()) {
                            newRequest = new PostRequest(
                                source: "Android",
                                templateName: "OTP",
                                phoneNumber: mobileNumberVerificationScheduler
                                    .mobileNumber,
                                language: "English");

                            userDetailsProvider.mobileNumber =
                                mobileNumberVerificationScheduler.mobileNumber;
                            _asyncKey.currentState
                                .reloadState()
                                .whenComplete(() => print('finished reload'));
                            // getResponse(requestBody: newRequest.toMap());
                          }
                        },
                  child: _asyncLoader,
                  color: AppTheme().myPrimaryMaterialColor.shade800,
                ),
          ),
    );
  }
}
