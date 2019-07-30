import 'package:flutter/material.dart';

import '../appTheme.dart';

class AppHome extends StatefulWidget {
  AppHome({Key key}) : super(key: key);

  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
