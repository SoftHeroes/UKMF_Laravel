import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../appTheme.dart';

import 'dart:async';

// import 'dart:math';
import 'package:flutter/material.dart';

import 'otpVerificationScheduler.dart';

class OTPLoader extends StatefulWidget {
  OTPLoader({Key key}) : super(key: key);

  _OTPLoaderState createState() => _OTPLoaderState();
}

class _OTPLoaderState extends State<OTPLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;

  final double initialRadius = 55.0;
  int initialTimerCount = 30, timerCount = 0;

  bool isCanResentOTP = true, isShowingLoader = true;

  @override
  void initState() {
    timerCount = initialTimerCount;

    controller = AnimationController(
        vsync: this, duration: Duration(seconds: initialTimerCount));

    animationRotation =
        Tween<double>(begin: 0.0, end: (1.0 + (1 / initialTimerCount))).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 1.0, curve: Curves.linear)));

    super.initState();
  }

  // startLoading() {}

/* Correct Timer part
  Upload all update contain in server
*/

  void startTimer(var otpVerificationSchedulerProviderRef) {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
            () {
              if (timerCount >= 1) {
                isCanResentOTP = false;
                otpVerificationSchedulerProviderRef.isCanResendOTP =
                    isCanResentOTP;
                timerCount = timerCount - 1;
                controller.repeat();
              } else {
                isShowingLoader = false;
                otpVerificationSchedulerProviderRef.isShowingLoader =
                    isShowingLoader;
                timerCount = initialTimerCount;
                timer.cancel();
                controller.stop();
                isCanResentOTP = true;
                otpVerificationSchedulerProviderRef.isCanResendOTP =
                    isCanResentOTP;
              }
            },
          ),
    );
  }

  Widget showLoader(var otpVerificationSchedulerProviderRef) {
    Widget returnValue;

    if (otpVerificationSchedulerProviderRef.isShowingLoader) {
      if (isCanResentOTP) {
        startTimer(otpVerificationSchedulerProviderRef);
      }

      returnValue = Stack(
        children: <Widget>[
          RotationTransition(turns: animationRotation, child: LoadingIcon()),
          Transform.translate(
            offset: Offset(timerCount > 9 ? 17 : 22, 17),
            child: Text(
              timerCount.toString(),
              style: AppTheme(appTextColor: Colors.grey, appTextFontSize: 18)
                  .appTextStyle,
            ),
          ),
        ],
      );
    } else {
      returnValue = Container();
    }

    return returnValue;
  }

  loadingObject(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final otpVerificationScheduler =
        Provider.of<OTPVerificationScheduler>(context);
    // print("timerCount $timerCount");
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
      width: 100,
      height: 100,
      child: showLoader(otpVerificationScheduler),
    );
  }
}

class LoadingIcon extends StatelessWidget {
  final double radiusOfRing;
  final double radiusOfDot;
  LoadingIcon({this.radiusOfRing = 55.0, this.radiusOfDot = 20.0});

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
        Transform.translate(
          offset: Offset(18, -6),
          child: Container(
            width: radiusOfDot,
            height: radiusOfDot,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme().myPrimaryMaterialColor.shade700),
          ),
        )
      ],
    );
  }
}
