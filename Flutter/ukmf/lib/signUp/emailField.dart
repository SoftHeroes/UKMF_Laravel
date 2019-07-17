import '../appTheme.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
      decoration: InputDecoration(
        hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
        hintText: 'Email',
      ),
    );
  }
}
