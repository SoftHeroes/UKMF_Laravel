import 'dart:convert';

import '../appTheme.dart';
import '../setup.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'mySchedule.dart';

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

  Future<String> getDate({Map requestBody}) async {
    // http.Response response = await http.get(Uri.encodeFull(setupRef.testLink),
    //     headers: {"Accept": "application/json"});

    http.Response response =
        await http.post(Uri.encodeFull(setupRef.server + setupRef.smsSent),
            // headers: {"Content-Type": "application/json"},
            body: requestBody);

    print(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyScheduler>(
      builder: (context, scheduler, _) => MaterialButton(
            disabledColor: Colors.grey,
            minWidth: double.infinity,
            height: 50.0,
            animationDuration: Duration(seconds: 10),
            onPressed: !scheduler.isIAgree
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      PostRequest newRequest = new PostRequest(
                          source: "Android",
                          templateName: "OTP",
                          phoneNumber: "9074200979",
                          language: "English");
                      getDate(requestBody: newRequest.toMap());
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
