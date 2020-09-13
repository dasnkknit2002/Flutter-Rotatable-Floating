import 'dart:math';

import 'allow_all_gesture_recognizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// {@tool snippet}
///
/// This example shows how to create a [Rotatable].
///
/// ```dart
/// Rotatable(
///   Container(width: 300.0, height: 300.0, color: Colors.yellow),
/// )
/// ```
/// {@end-tool}
///
///
class Rotatable extends StatefulWidget {
  Rotatable(this.child, {Key key, this.initialAngle = 0.0}) : super(key: key);
  final Widget child;
  final double initialAngle;

  @override
  _RotatableState createState() => _RotatableState();
}

class _RotatableState extends State<Rotatable> {
  double angle;
  @override
  void initState() {
    super.initState();
    angle = widget.initialAngle;
  }

  Offset original;
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
        child: Transform.rotate(
            angle: angle, child: widget.child, transformHitTests: true),
        gestures: <Type, GestureRecognizerFactory>{
          AllowAllGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<AllowAllGestureRecognizer>(
            () => AllowAllGestureRecognizer(onPanStart: (details) {
              RenderBox box = context.findRenderObject() as RenderBox;
              original = box.localToGlobal(Offset.zero);
              HitTestResult result = HitTestResult();
              WidgetsBinding.instance.hitTest(result,
                  Offset(details.globalPosition.dx, details.globalPosition.dy));
              var hitTestEntry =
                  result.path.where((element) => element.target == box);
              if (hitTestEntry.isNotEmpty) {
                updateRotationAngle(original, box.size, details.globalPosition);
              }
            }, onPanUpdate: (details) {
              RenderBox box = context.findRenderObject() as RenderBox;
              HitTestResult result = HitTestResult();
              WidgetsBinding.instance.hitTest(result,
                  Offset(details.globalPosition.dx, details.globalPosition.dy));
              var hitTestEntry =
                  result.path.where((element) => element.target == box);
              if (hitTestEntry.isNotEmpty) {
                updateRotationAngle(original, box.size, details.globalPosition);
              } else {
                setState(() {
                  angle = 0;
                });
              }
            }, onPanEnd: (details) {
              setState(() {
                angle = 0;
              });
            }),
            (AllowAllGestureRecognizer instance) {},
          ),
        });
  }

  void updateRotationAngle(Offset origin, Size size, Offset position) {
    Offset center = origin.translate(size.width / 2, size.height / 2);
    var a = position.dx - center.dx;
    var b = center.dy - position.dy;
    setState(() {
      angle = pi / 2 - atan2(b, a);
    });
  }
}
