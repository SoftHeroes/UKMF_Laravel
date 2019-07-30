import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukmf/appTheme.dart';
import 'package:ukmf/mobileNumberVerification/mobileNumberVerification.dart';
import 'package:ukmf/splashScreenScheduler.dart';

import 'home/home.dart';
import 'setup.dart';

class PostRequest {
  final String username, password, language, source;

  PostRequest({this.username, this.password, this.language, this.source});

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return PostRequest(
        username: json['username'],
        password: json['password'],
        language: json['language'],
        source: json['source']);
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

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool _canSentAPI = false;
  String _user, _password;
  PostRequest newRequest;
  final Setup setupRef = Setup();

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () {
        setState(() {
          _canSentAPI = true;
        });
      },
    );
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    _user = prefs.getString('user') ?? null;
    _password = prefs.getString('password') ?? null;

    print('read: User : $_user Pass : $_password');
  }

  getResponse(SplashScreenScheduler splashScreenScheduler,
      {Map requestBody}) async {
    splashScreenScheduler.isLogin = true;
    var response =
        await post(setupRef.server + setupRef.loginCustomer, body: requestBody);
    splashScreenScheduler.isLogin = false;
    splashScreenScheduler.isLoginCompeted = true;

    splashScreenScheduler.response = response;
  }

  List<Widget> _buildForm(
    BuildContext context,
    SplashScreenScheduler splashScreenScheduler,
  ) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (_canSentAPI) {
          _canSentAPI = false;
          print('I Am rebuild');

          await _read();
          if (_user == null || _password == null) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => MobileNumberVerification()));
          } else {
            newRequest = new PostRequest(
                username: _user,
                password: _password,
                source: setupRef.source,
                language: setupRef.language);

            getResponse(
              splashScreenScheduler,
              requestBody: newRequest.toMap(),
            );
          }
        }
      },
    );

    Column page = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image.asset('assets/companyLogo.png'),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 50,
                color: AppTheme().myPrimaryMaterialColor.shade500,
              ),
              Container(
                height: 30,
                color: AppTheme().myPrimaryMaterialColor.shade800,
              )
            ],
          ),
        ),
      ],
    );

    var pagelist = new List<Widget>();
    pagelist.add(page);

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
      pagelist.add(modal);
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (splashScreenScheduler.isLoginCompeted) {
          splashScreenScheduler.isLoginCompeted = false;
          Response response = splashScreenScheduler.response;
          splashScreenScheduler.response = null;

          if (response != null) {
            if (response.statusCode != HttpStatus.ok) {
              print('Load Login Page');
            } else {
              dynamic jsonData = json.decode(response.body);

              if (jsonData["ErrorFound"] == "NO") {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => AppHome()));
              } else {
                print('Load login page');
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
