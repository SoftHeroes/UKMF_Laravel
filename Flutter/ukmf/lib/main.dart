import 'package:provider/provider.dart';

import './appTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'AppLoad/mobileNumberVerification/mobileNumberVerification.dart';
import 'AppLoad/userDetailsProvider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: AppTheme().myPrimaryMaterialColor),
      home: ChangeNotifierProvider(
        builder: (context) => UserDetailsProvider(),
        child: MobileNumberVerification(),
      ),
    );
  }
}
