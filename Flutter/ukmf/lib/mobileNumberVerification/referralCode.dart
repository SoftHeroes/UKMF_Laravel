import '../appTheme.dart';

import 'package:flutter/material.dart';

class ReferralCode extends StatefulWidget {
  _ReferralCodeState createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> {
  bool _isText = true;

  Widget _buildchild(BuildContext context) {
    Widget child;
    if (_isText) {
      child = GestureDetector(
        onTap: () {
          setState(() {
            _isText = false;
          });
        },
        child: Text(
          'Got a referral code ?',
          style: AppTheme(isLink: true).appTextStyle,
        ),
      );
    } else {
      child = Container(
        width: 270.0,
        child: TextFormField(
          style: AppTheme(appTextLetterSpacing: 2).appTextStyle,
          decoration: InputDecoration(
            hintStyle: AppTheme(appTextColor: Colors.grey).appTextStyle,
            hintText: 'Enter Referral Code',
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isText = true;
                });
              },
              child: Icon(
                Icons.clear,
                size: 30,
              ),
            ),
          ),
          validator: (String value) {
            return value.length != 7 ? 'Invalide Referral Code.' : null;
          },
        ),
      );
    }
    return new Container(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100.0, 33.0, 0, 0),
      child: _buildchild(context),
    );
  }
}
