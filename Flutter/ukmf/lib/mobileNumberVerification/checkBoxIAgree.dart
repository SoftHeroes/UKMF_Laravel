import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mySchedule.dart';

class CheckBoxIAgree extends StatefulWidget {
  _CheckBoxIAgreeState createState() => _CheckBoxIAgreeState();
}

class _CheckBoxIAgreeState extends State<CheckBoxIAgree> {
  double _textSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<MyScheduler>(context);
    return Row(
      children: <Widget>[
        Checkbox(
          onChanged: (value) => schedule.isIAgree = value,
          value: schedule.isIAgree,
        ),
        Text(
          'I agree to ',
          style: AppTheme(appTextFontSize: _textSize).appTextStyle,
        ),
        Text(
          'Terms & Conditions',
          style:
              AppTheme(isLink: true, appTextFontSize: _textSize).appTextStyle,
        )
      ],
    );
  }
}
