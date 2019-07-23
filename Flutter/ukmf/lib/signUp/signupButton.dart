import 'package:toast/toast.dart';

import '../appTheme.dart';
import '../setup.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'signupScheduler.dart';

class PostRequest {
  final String password,
      confirmPassword,
      firstName,
      middleName,
      lastName,
      emailID,
      phoneNumber,
      planID,
      language,
      source;

  PostRequest(
      {this.password,
      this.confirmPassword,
      this.firstName,
      this.middleName,
      this.lastName,
      this.emailID,
      this.phoneNumber,
      this.planID = "1",
      this.language,
      this.source});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
        password: json['password'],
        confirmPassword: json['confirmPassword'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        emailID: json['emailID'],
        phoneNumber: json['phoneNumber'],
        planID: json['planID'],
        language: json['language'],
        source: json['source']);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["password"] = password;
    map["confirmPassword"] = confirmPassword;
    map["firstName"] = firstName;
    map["middleName"] = middleName;
    map["lastName"] = lastName;
    map["emailID"] = emailID;
    map["phoneNumber"] = phoneNumber;
    map["planID"] = planID;
    map["language"] = language;
    map["source"] = source;

    return map;
  }
}

class SignupButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String mobileNumber;
  SignupButton({this.formKey, this.mobileNumber = ""});

  @override
  Widget build(BuildContext context) {
    final Setup setupRef = Setup();
    PostRequest newRequest;

    getResponse(SignUpScheduler signUpScheduler, {Map requestBody}) async {
      print(setupRef.server + setupRef.signupCustomer);

      signUpScheduler.isSigningUp = true;
      var response = await post(setupRef.server + setupRef.signupCustomer,
          body: requestBody);
      signUpScheduler.isSigningUp = false;

      signUpScheduler.response = response;
    }

    return Consumer<SignUpScheduler>(builder: (context, signUpScheduler, _) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          MaterialButton(
            disabledColor: Colors.grey,
            minWidth: double.infinity,
            height: 50.0,
            onPressed: () async {
              if (formKey.currentState.validate()) {
                newRequest = new PostRequest(
                  source: setupRef.source,
                  language: setupRef.language,
                  phoneNumber: mobileNumber,
                  firstName: signUpScheduler.firstName,
                  lastName: signUpScheduler.lastName,
                  emailID: signUpScheduler.emailID,
                  password: signUpScheduler.password,
                  confirmPassword: signUpScheduler.confirmPassword,
                );

                getResponse(signUpScheduler, requestBody: newRequest.toMap());
              }
            },
            color: AppTheme().myPrimaryMaterialColor.shade800,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: Text(
              'Sign Up',
              style: AppTheme(appTextColor: Colors.white).appTextStyle,
            ),
          ),
        ],
      );
    });
  }
}
