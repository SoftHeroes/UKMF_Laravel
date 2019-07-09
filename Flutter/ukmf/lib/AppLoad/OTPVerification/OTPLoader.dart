import '../../appTheme.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

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
  int initialTimerCount = 60, timerCount = -1;

  bool isCanResentOTP = true, isShowingLoader = true;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    void startTimer(var otpVerificationSchedulerRef) {
      Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => setState(
              () {
                if (timerCount >= 1) {
                  isCanResentOTP = false;
                  otpVerificationSchedulerRef.isCanResendOTP = isCanResentOTP;
                  timerCount = timerCount - 1;
                  controller.repeat();
                } else {
                  isShowingLoader = false;
                  otpVerificationSchedulerRef.isShowingLoader = isShowingLoader;
                  timerCount = -1;
                  timer.cancel();
                  controller.stop();
                  isCanResentOTP = true;
                  otpVerificationSchedulerRef.isCanResendOTP = isCanResentOTP;
                }
              },
            ),
      );
    }

    Widget showLoader(var otpVerificationSchedulerRef) {
      print('i am here');
      Widget returnValue;

      if (otpVerificationSchedulerRef.isShowingLoader) {
        if (otpVerificationSchedulerRef.isCanResendOTP && timerCount == -1) {
          print('i am here 2');
          timerCount = initialTimerCount;
          startTimer(otpVerificationSchedulerRef);
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

    return Consumer<OTPVerificationScheduler>(
        builder: (context, otpVerificationScheduler, _) {
      print('i am in builder ');
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
        width: 100,
        height: 100,
        child: showLoader(otpVerificationScheduler),
      );
    });
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
