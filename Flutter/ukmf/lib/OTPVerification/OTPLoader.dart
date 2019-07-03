import 'dart:math';

import 'package:flutter/material.dart';

class OTPLoader extends StatefulWidget {
  OTPLoader({Key key}) : super(key: key);

  _OTPLoaderState createState() => _OTPLoaderState();
}

class _OTPLoaderState extends State<OTPLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initialRadius = 30.0;
  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialRadius;
        }
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: radius,
                color: Colors.black12,
              ),
              Transform.translate(
                offset: Offset(cos(pi / 4) * radius, sin(pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.redAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(2 * pi / 4) * radius, sin(2 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(3 * pi / 4) * radius, sin(3 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.blueAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(4 * pi / 4) * radius, sin(4 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.pinkAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(5 * pi / 4) * radius, sin(5 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.orangeAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(6 * pi / 4) * radius, sin(6 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(7 * pi / 4) * radius, sin(7 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.limeAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(cos(8 * pi / 4) * radius, sin(8 * pi / 4) * radius),
                child: Dot(
                  radius: 5,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
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
