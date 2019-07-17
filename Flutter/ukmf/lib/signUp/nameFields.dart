import 'package:flutter/material.dart';

import '../appTheme.dart';

class FirstName extends StatelessWidget {
  const FirstName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
        hintText: 'First Name',
      ),
    );
  }
}

class LastName extends StatelessWidget {
  const LastName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
        hintText: 'Last Name',
      ),
    );
  }
}
