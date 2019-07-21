import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signupScheduler.dart';

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpScheduler>(
      builder: (context, signUpScheduler, _) => TextFormField(
        obscureText: true,
        style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
        decoration: InputDecoration(
          hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
          hintText: 'Confirm Password',
        ),
        validator: (String textValue) {
          signUpScheduler.confirmPassword = textValue;
          if (textValue.length == 0)
            return "Confirm Password cannot be empty.";
          else
            return null;
        },
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpScheduler>(
      builder: (context, signUpScheduler, _) => TextFormField(
        obscureText: true,
        style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
        decoration: InputDecoration(
          hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
          hintText: 'Password',
        ),
        validator: (String textValue) {
          signUpScheduler.password = textValue;
          if (textValue.length == 0)
            return "Password cannot be empty.";
          else
            return null;
        },
      ),
    );
  }
}
