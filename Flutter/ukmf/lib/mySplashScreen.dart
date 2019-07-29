import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:ukmf/appTheme.dart';
import 'package:ukmf/splashScreenScheduler.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool _canSentAPI = false;

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

  List<Widget> _buildForm(
    BuildContext context,
    SplashScreenScheduler splashScreenScheduler,
  ) {
    if (_canSentAPI) {
      print('I Am rebuild');
    }

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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
                child: CircularProgressIndicator(),
              ),
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
              // Load Login Page
            } else {
              dynamic jsonData = json.decode(response.body);

              if (jsonData["ErrorFound"] == "NO") {
                // Load home page
              } else {
                // Load login page
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
