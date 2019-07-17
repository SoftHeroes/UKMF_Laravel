import 'package:flutter/widgets.dart';
import 'package:ukmf/signUp/passwordFields.dart';
import 'package:ukmf/signUp/signupButton.dart';

import '../appTheme.dart';

import 'package:flutter/material.dart';

import 'emailField.dart';
import 'nameFields.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: AppTheme().myPrimaryMaterialColor.shade500,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          child: IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'Enter your details for Registration',
                style: AppTheme(appTextColor: Colors.black).appTextStyle,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  FirstName(),
                  SizedBox(
                    height: 30,
                  ),
                  LastName(),
                  SizedBox(
                    height: 30,
                  ),
                  EmailField(),
                  SizedBox(
                    height: 30,
                  ),
                  PasswordField(),
                  SizedBox(
                    height: 30,
                  ),
                  ConfirmPasswordField()
                ],
              ),
            ),
            SignupBotton()
          ],
        ),
      ),
    );
  }
}
