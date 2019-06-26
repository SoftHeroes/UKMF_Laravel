import 'package:flutter/material.dart';

class MobileNumberTextField extends StatelessWidget {
  final double widthLength;
  MobileNumberTextField({this.widthLength = 280.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthLength,
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          hintText: 'Mobile Number',
          icon: Icon(Icons.phone),
        ),
        validator: (String value) {
          return value.length != 10 ? 'Invalide Mobile Number.' : null;
        },
      ),
    );
  }
}
