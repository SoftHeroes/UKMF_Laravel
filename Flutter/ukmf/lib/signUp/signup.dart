import 'package:flutter/widgets.dart';

import '../appTheme.dart';

import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
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
                  TextFormField(
                      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
                      decoration: InputDecoration(
                        hintStyle:
                            AppTheme(appTextColor: Colors.grey).appTextStyle,
                        hintText: 'Full Name',
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
                      decoration: InputDecoration(
                        hintStyle:
                            AppTheme(appTextColor: Colors.grey).appTextStyle,
                        hintText: 'Email',
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
                      decoration: InputDecoration(
                        hintStyle:
                            AppTheme(appTextColor: Colors.grey).appTextStyle,
                        hintText: 'Password',
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
                      decoration: InputDecoration(
                        hintStyle:
                            AppTheme(appTextColor: Colors.grey).appTextStyle,
                        hintText: 'Confirm Password',
                      ))
                ],
              ),
            ),
            Expanded(
              child:
                  Stack(alignment: Alignment.bottomCenter, children: <Widget>[
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
            )
          ],
        ));
  }
}
