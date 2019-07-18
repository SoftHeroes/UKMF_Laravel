import '../appTheme.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        MaterialButton(
          disabledColor: Colors.grey,
          minWidth: double.infinity,
          height: 50.0,
          onPressed: () {},
          color: AppTheme().myPrimaryMaterialColor.shade800,
          child: Text(
            'Sign Up',
            style: AppTheme(appTextColor: Colors.white).appTextStyle,
          ),
        ),
      ]),
    );
  }
}
