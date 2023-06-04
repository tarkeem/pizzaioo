import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  Widget child;
  Axis axis;
  double offset;
  Duration duration;
  ShakeTransition(
      {required this.child,
      this.offset = 140,
      this.duration = const Duration(milliseconds: 700),
      this.axis = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      curve: Curves.elasticOut,
      tween: Tween(begin: 1, end: 0),
      duration: duration,
      builder: (context, value, child) =>
          Transform.translate(
            child: child,
            offset:axis==Axis.horizontal?Offset(value * offset, 0):Offset(0, value * offset)
            
            ),
    );
  }
}
