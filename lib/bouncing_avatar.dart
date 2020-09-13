import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'allow_all_gesture_recognizer.dart';
import 'rotatable.dart';

class BouncingAvatar extends StatefulWidget {
  final Widget child;
  BouncingAvatar(this.child);
  @override
  State<StatefulWidget> createState() {
    return BouncingAvatarState();
  }
}

class BouncingAvatarState extends State<BouncingAvatar>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  AnimationController dragController;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 200),
        vsync: this,
        animationBehavior: AnimationBehavior.normal);

    scaleAnimation = Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.easeInCirc))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    dragController = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
        animationBehavior: AnimationBehavior.normal);

    curvedAnimation =
        CurvedAnimation(parent: dragController, curve: Curves.fastOutSlowIn);
    dragController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!showChild) {
          entry.remove();
        }
        entry = null;
        dragController.reset();
        setState(() {
          angle = 0;
          showChild = true;
        });
      }
    });
    dragController.addListener(() {
      if (entry != null) {
        _dragAlignment = returnAnimation.value;
        entry.markNeedsBuild();
      }
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  OverlayEntry entry;
  Alignment _dragAlignment;
  Animation<Alignment> returnAnimation;
  bool showChild = true;
  Offset original;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    Widget rotatedChild = Rotatable(widget.child);
    Widget animatedChild = ScaleTransition(
        child: showChild ? rotatedChild : Container(), scale: scaleAnimation);
    return RawGestureDetector(child: animatedChild, gestures: <Type,
        GestureRecognizerFactory>{
      AllowAllGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<AllowAllGestureRecognizer>(
              () => AllowAllGestureRecognizer(onTap: () {
                    setState(() {
                      controller.forward();
                    });
                  }, onPanDown: (details) {
                    dragController.stop(canceled: true);
                  }, onPanStart: (details) {
                    RenderBox box = context.findRenderObject() as RenderBox;
                    original = box.localToGlobal(Offset.zero);
                    _dragAlignment = Alignment(original.dx, original.dy);
                    entry = OverlayEntry(builder: (BuildContext con) {
                      return Positioned(
                          left: _dragAlignment.x,
                          top: _dragAlignment.y,
                          child: widget.child);
                    });
                    if (!_checkIfWithinBoundary(box, details.globalPosition)) {
                      var overlayState =
                          Overlay.of(context, debugRequiredFor: rotatedChild);
                      overlayState.insert(entry);
                      entry.markNeedsBuild();
                      setState(() {
                        showChild = false;
                      });
                    }
                  }, onPanUpdate: (DragUpdateDetails details) {
                    RenderBox box = context.findRenderObject() as RenderBox;
                    if (!_checkIfWithinBoundary(box, details.globalPosition)) {
                      if (showChild) {
                        var overlayState =
                            Overlay.of(context, debugRequiredFor: rotatedChild);
                        overlayState.insert(entry);
                        entry.markNeedsBuild();
                        setState(() {
                          showChild = false;
                        });
                      }
                      _dragAlignment +=
                          Alignment(details.delta.dx, details.delta.dy);
                      entry.markNeedsBuild();
                    }
                  }, onPanEnd: (Offset details) {
                    Alignment start = _dragAlignment;
                    returnAnimation = AlignmentTween(
                            begin: start,
                            end: Alignment(original.dx, original.dy))
                        .animate(curvedAnimation);
                    dragController.forward();
                  }),
              (AllowAllGestureRecognizer instance) {})
    });
  }

  bool _checkIfWithinBoundary(RenderBox box, Offset globalPosition) {
    //RenderBox box = context.findRenderObject() as RenderBox;
    HitTestResult result = HitTestResult();
    WidgetsBinding.instance
        .hitTest(result, Offset(globalPosition.dx, globalPosition.dy));
    var hitTestEntry = result.path.where((element) => element.target == box);
    return hitTestEntry.isNotEmpty;
  }
}
