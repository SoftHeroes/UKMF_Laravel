import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../appTheme.dart';
import 'otpVerificationScheduler.dart';

class OTPField extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  OTPField({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  @override
  _OTPFieldState createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  final TextEditingController _textFieldController =
      new TextEditingController();

  List<BoxShadow> getBoxShadow() {
    List<BoxShadow> returnBoxShadow = new List<BoxShadow>();

    BoxShadow boxShadow = BoxShadow(
      color: Colors.grey,
      blurRadius: 10,
      spreadRadius: 1,
      offset: Offset(3, 6),
    );

    returnBoxShadow.add(boxShadow);
    return returnBoxShadow;
  }

  @override
  Widget build(BuildContext context) {
    void onChange() {
      widget._formKey.currentState.validate();
    }

    bool isfirstLoad = true;
    _textFieldController.addListener(onChange);

    return Consumer<OTPVerificationScheduler>(
      builder: (context, otpVerificationScheduler, _) => Container(
        padding: EdgeInsets.fromLTRB(6.5, 0, 0, 0),
        width: 240,
        height: 52,
        decoration: BoxDecoration(
            boxShadow: getBoxShadow(),
            color: Colors.white,
            border: Border.all(
                width: 2.5,
                color: otpVerificationScheduler.enterOTP.length != 6
                    ? Colors.red
                    : AppTheme().myPrimaryMaterialColor.shade200),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Transform(
          transform: Matrix4.translationValues(0, 9, 0),
          child: TextFormField(
            controller: _textFieldController,
            textAlign: TextAlign.center,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '',
              hintStyle: AppTheme(
                      appfontWeight: FontWeight.bold,
                      appTextFontSize: 32,
                      appTextColor: Colors.grey)
                  .appTextStyle,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
            ],
            style: AppTheme(
                    appTextFontSize: 32,
                    appfontWeight: FontWeight.bold,
                    appTextLetterSpacing: 15)
                .appTextStyle,
            validator: (String newValue) {
              if (!isfirstLoad) {
                print('validator called');
                otpVerificationScheduler.enterOTP = newValue;
              } else {
                isfirstLoad = false;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
