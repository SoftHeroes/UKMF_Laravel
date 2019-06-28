import 'package:flutter/material.dart';
import 'appTheme.dart';

class DropDownList extends StatefulWidget {
  final List listValues;
  final String dropDownDefaultValue;

  DropDownList(this.listValues, {this.dropDownDefaultValue});

  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  dynamic dropdownValue;
  dynamic dropDownValues;

  @override
  void initState() {
    dropdownValue = widget.dropDownDefaultValue;
    dropDownValues = widget.listValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      key: GlobalKey(),
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: dropDownValues.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: AppTheme().appTextStyle,
          ),
        );
      }).toList(),
    );
  }
}
