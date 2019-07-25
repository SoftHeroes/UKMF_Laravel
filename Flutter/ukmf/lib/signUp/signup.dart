import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../appTheme.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'emailField.dart';
import 'nameFields.dart';
import 'passwordFields.dart';
import 'signupButton.dart';
import 'signupScheduler.dart';

class SignUp extends StatefulWidget {
  final String phoneNumber;
  SignUp({this.phoneNumber = "9074200979"});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _save(String user, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
    prefs.setString('password', password);
  }

  final _formKey = GlobalKey<FormState>();

  List<Widget> _buildForm(
    BuildContext context,
    SignUpScheduler signUpScheduler,
    BoxConstraints viewportConstraints,
  ) {
    Form form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 50,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
            width: viewportConstraints.maxWidth,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Enter your details for Registration',
                    style: AppTheme(appTextColor: Colors.black).appTextStyle,
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
                SizedBox(
                  height: 150,
                ),
                SignupButton(
                  formKey: _formKey,
                  mobileNumber: widget.phoneNumber,
                )
                // SignupButton()
              ],
            ),
          ),
        ),
      ),
    );

    var pagelist = new List<Widget>();
    pagelist.add(form);

    if (signUpScheduler.isSigningUp) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      pagelist.add(modal);
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (signUpScheduler.isSigningUpCompleted) {
          signUpScheduler.isSigningUpCompleted = false;

          Response response = signUpScheduler.response;
          signUpScheduler.response = null;
          if (response != null) {
            if (response.statusCode != HttpStatus.ok) {
              Toast.show("Unable to signup currently", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            } else {
              dynamic jsonData = json.decode(response.body);

              if (jsonData["ErrorFound"] == "NO") {
                _save(signUpScheduler.phoneNumber, signUpScheduler.password);

                print('Sign up succefull');
              } else if (jsonData["Code"] == "ERR00000") {
                Toast.show("Unable to signup currently", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              } else {
                Toast.show(jsonData["Message"], context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            }
          }
        }
      },
    );

    return pagelist;
  }

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
          return ChangeNotifierProvider(
            builder: (context) => SignUpScheduler(),
            child: Consumer<SignUpScheduler>(
              builder: (context, signUpScheduler, _) => Stack(
                children:
                    _buildForm(context, signUpScheduler, viewportConstraints),
              ),
            ),
          );
        },
      ),
    );
  }
}
