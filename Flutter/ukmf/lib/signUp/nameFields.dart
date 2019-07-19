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
      validator: (String textValue) {
        if (textValue.length == 0)
          return "First Name cannot be empty.";
        else
          return null;
      },
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
      validator: (String textValue) {
        if (textValue.length == 0)
          return "Last Name cannot be empty.";
        else
          return null;
      },
    );
  }
}
