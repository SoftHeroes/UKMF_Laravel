import '../appTheme.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  SignupButton({this.formKey});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        MaterialButton(
          disabledColor: Colors.grey,
          minWidth: double.infinity,
          height: 50.0,
          onPressed: () {
            if (formKey.currentState.validate()) {}
          },
          color: AppTheme().myPrimaryMaterialColor.shade800,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          child: Text(
            'Sign Up',
            style: AppTheme(appTextColor: Colors.white).appTextStyle,
          ),
        ),
      ],
    );
  }
}
