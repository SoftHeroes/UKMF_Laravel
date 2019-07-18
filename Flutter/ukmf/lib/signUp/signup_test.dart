import 'package:flutter/widgets.dart';
import 'package:ukmf/signUp/passwordFields.dart';
import 'package:ukmf/signUp/signupButton.dart';

import '../appTheme.dart';

import 'package:flutter/material.dart';

import 'emailField.dart';
import 'nameFields.dart';

class SignUpTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Form(
                child: Container(
                  padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                  width: viewportConstraints.maxWidth,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Enter your details for Registration',
                          style:
                              AppTheme(appTextColor: Colors.black).appTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
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
                      ConfirmPasswordField(),
                      // SignupButton()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
