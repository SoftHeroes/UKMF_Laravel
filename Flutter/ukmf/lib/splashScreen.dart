import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:ukmf/mobileNumberVerification/mobileNumberVerification.dart';
import 'package:ukmf/splashScreenScheduler.dart';

import 'setup.dart';

import 'package:ukmf/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRequest {
  final String username, password, language, source;

  PostRequest({this.username, this.password, this.language, this.source});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
      username: json['username'],
      password: json['password'],
      language: json['language'],
      source: json['source'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["language"] = language;
    map["source"] = source;

    return map;
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String user;
  String password;
  final Setup setupRef = Setup();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _read();

        if (user == null || password == null) {
          Route route = MaterialPageRoute(
              builder: (context) => MobileNumberVerification());
          Navigator.pushReplacement(context, route);
        }
        Consumer<SplashScreenScheduler>(
          builder: (context, splashScreenScheduler, _) {
            PostRequest newRequest;
            newRequest = new PostRequest(
                source: setupRef.source,
                username: user,
                password: password,
                language: setupRef.language);

            return getResponse(
              splashScreenScheduler,
              requestBody: newRequest.toMap(),
            );
          },
        );
      },
    );

    super.initState();
  }

  List<Widget> _buildForm(
    BuildContext context,
    SplashScreenScheduler splashScreenScheduler,
  ) {
    Center form = Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 500.0,
            width: 500.0,
            child: Image.asset('assets/companyLogo.png'),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 30.0,
                  color: AppTheme().myPrimaryMaterialColor.shade500,
                ),
                Container(
                  height: 20.0,
                  color: AppTheme().myPrimaryMaterialColor.shade800,
                ),
              ],
            ),
          )
        ],
      ),
    );

    var pagelist = new List<Widget>();
    pagelist.add(form);

    if (splashScreenScheduler.isLogin) {
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

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (splashScreenScheduler.isLoginCompeted) {
            splashScreenScheduler.isLoginCompeted = false;
            Response response = splashScreenScheduler.response;
            splashScreenScheduler.response = null;
            if (response != null) {
              if (response.statusCode != HttpStatus.ok) {
                print('Load login page');
              } else {
                dynamic jsonData = json.decode(response.body);

                if (jsonData["ErrorFound"] == "NO") {
                  print('Load home page');
                } else {
                  print('Load login page');
                }
              }
            }
          }
        },
      );

      pagelist.add(modal);
    }

    return pagelist;
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();

    user = prefs.getString('user') ?? null;
    password = prefs.getString('password') ?? null;
    print('read: user : $user password : $password');
  }

  getResponse(SplashScreenScheduler splashScreenScheduler,
      {Map requestBody, BuildContext context}) async {
    print('Get Response');
    splashScreenScheduler.isLogin = true;
    var resposne =
        await post(setupRef.server + setupRef.smsSent, body: requestBody);
    splashScreenScheduler.isLogin = false;
    splashScreenScheduler.isLoginCompeted = true;
    splashScreenScheduler.response = resposne;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        builder: (context) => SplashScreenScheduler(),
        child: Consumer<SplashScreenScheduler>(
          builder: (context, splashScreenScheduler, _) => Stack(
            children: _buildForm(context, splashScreenScheduler),
          ),
        ),
      ),
    );
  }
}
