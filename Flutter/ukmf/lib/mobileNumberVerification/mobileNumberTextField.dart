import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileNumberTextField extends StatelessWidget {
  final double widthLength;
  MobileNumberTextField({this.widthLength = 270.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthLength,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
          hintText: 'Mobile Number',
          suffixIcon: Icon(Icons.phone),
        ),
        validator: (String value) {
          return value.length != 10 ? 'Invalide Mobile Number.' : null;
        },
      ),
    );
  }
}