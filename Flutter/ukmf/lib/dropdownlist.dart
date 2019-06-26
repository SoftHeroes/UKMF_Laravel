import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final List listValues;
  final String dropDownDefaultValue;

  DropDownList(this.listValues, {this.dropDownDefaultValue});

  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  dynamic dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.dropDownDefaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: widget.listValues.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
