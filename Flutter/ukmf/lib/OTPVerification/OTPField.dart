import '../appTheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool isSumbitedOnce = false;

class OTPValue extends StatelessWidget {
  final double spacing;
  final int count;
  OTPValue({this.count, this.spacing = 15.0});

  @override
  Widget build(BuildContext context) {
    Widget getTextWidgets(int count) {
      List<Widget> list = new List<Widget>();

      FocusNode nextFocusNode;
      for (var i = 0; i < count; i++) {
        SingleOTPValue temp = SingleOTPValue(nextFocusNode);
        nextFocusNode = temp.myfocus;

        if (i == count - 1 && !isSumbitedOnce) {
          FocusScope.of(context).requestFocus(temp.myfocus);
        }
        list.add(temp);

        if (i != count - 1)
          list.add(SizedBox(
            width: spacing,
          ));
      }
      return new Row(
          children: list.reversed.toList(),
          mainAxisAlignment: MainAxisAlignment.center);
    }

    return getTextWidgets(count);
  }
}

class SingleOTPValue extends StatefulWidget {
  static const double _textSize = 32;

  final FocusNode nexttextFocusNode, _myfocus = FocusNode();
  SingleOTPValue(this.nexttextFocusNode);

  FocusNode get myfocus {
    return _myfocus;
  }

  @override
  _SingleOTPValueState createState() => _SingleOTPValueState();
}

class _SingleOTPValueState extends State<SingleOTPValue> {
  final TextEditingController _textFieldController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onChange() {
      if (!isSumbitedOnce &&
          _textFieldController.text.length > 0 &&
          widget._myfocus.hasFocus &&
          widget.nexttextFocusNode != null) {
        print('on change');
        FocusScope.of(context).requestFocus(widget.nexttextFocusNode);
      }
    }

    void onTap() {
      if (widget._myfocus.hasFocus && !isSumbitedOnce) {
        print('on tap else');
        FocusScope.of(context).requestFocus(widget.myfocus);
        _textFieldController.clear();
      }
    }

    widget._myfocus.addListener(onTap);
    _textFieldController.addListener(onChange);

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

    return Container(
      // margin: EdgeInsets.all(30.0),
      padding: EdgeInsets.fromLTRB(6.5, 0, 0, 0),
      width: 39,
      height: 52,
      child: Transform(
        child: TextFormField(
          controller: _textFieldController,
          focusNode: widget._myfocus,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '0',
            hintStyle: AppTheme(
                    appfontWeight: FontWeight.bold,
                    appTextFontSize: SingleOTPValue._textSize,
                    appTextColor: Colors.grey)
                .appTextStyle,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          style: AppTheme(
            appTextFontSize: SingleOTPValue._textSize,
            appfontWeight: FontWeight.bold,
          ).appTextStyle,
          onFieldSubmitted: (String value) {
            print('Sumbited called ');
            isSumbitedOnce = true;
          },
        ),
        transform: Matrix4.translationValues(0, 9, 0),
      ),
      decoration: BoxDecoration(
          boxShadow: getBoxShadow(),
          color: Colors.white,
          border: Border.all(
              width: 2.5, color: AppTheme().myPrimaryMaterialColor.shade200),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
    );
  }
}
