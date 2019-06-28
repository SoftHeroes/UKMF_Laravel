import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mySchedule.dart';

class GetOTPButton extends StatelessWidget {
  const GetOTPButton({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyScheduler>(
      builder: (context, scheduler, _) => MaterialButton(
            disabledColor: Colors.grey,
            minWidth: double.infinity,
            height: 50.0,
            animationDuration: Duration(seconds: 10),
            onPressed: !scheduler.isIAgree
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
            child: Text(
              'Get OTP',
              style: AppTheme(appTextColor: Colors.white).appTextStyle,
            ),
            color: AppTheme().myPrimaryMaterialColor.shade800,
          ),
    );
  }
}
