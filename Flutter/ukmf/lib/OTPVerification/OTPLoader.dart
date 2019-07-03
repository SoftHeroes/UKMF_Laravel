import 'dart:async';
import 'dart:io';

import '../appTheme.dart';

// import 'dart:math';
import 'package:flutter/material.dart';

class OTPLoader extends StatefulWidget {
  OTPLoader({Key key}) : super(key: key);

  _OTPLoaderState createState() => _OTPLoaderState();
}

class _OTPLoaderState extends State<OTPLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<double> animationTimeCounter;

  final double initialRadius = 55.0;
  int initialTimerCount = 30, timerCount = 30;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 30));

    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animationTimeCounter = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    controller.repeat();
  }

/* TODO : Correct Timer part
  Upload all update contain in server
*/

  void startTimer() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
            () {
              setState(() {
                if (timerCount >= 0) {
                  timerCount = timerCount - 1;
                } else {
                  timer.cancel();
                  timerCount = initialTimerCount;
                }
              });
            },
          ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer();

    // print("timerCount $timerCount");
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Column(
          children: <Widget>[
            RotationTransition(turns: animationRotation, child: LoadingIcon()),
            Text(timerCount.toString()),
          ],
        ),
      ),
    );
  }
}

class LoadingIcon extends StatelessWidget {
  final double radiusOfRing;
  final double radiusOfDot;
  LoadingIcon({this.radiusOfRing = 55.0, this.radiusOfDot = 22.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: radiusOfRing,
          height: radiusOfRing,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 8, color: Colors.black12)),
        ),
        Container(
          width: radiusOfDot,
          height: radiusOfDot,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme().myPrimaryMaterialColor.shade700),
        )
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
