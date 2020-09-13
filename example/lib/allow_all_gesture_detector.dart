import 'package:flutter/cupertino.dart';
import 'package:rotatable/allow_all_gesture_recognizer.dart';

class AllowAllGestureDetector extends StatelessWidget {
  final Widget child;

  final GestureDragUpdateCallback onPanUpdate;
  final VoidCallback onTap;
  final GestureDragDownCallback onPanDown;
  final Function onPanEnd;
  final GestureDragStartCallback onPanStart;

  const AllowAllGestureDetector(
      {Key key,
      this.onPanUpdate,
      this.onTap,
      this.onPanDown,
      this.onPanEnd,
      this.onPanStart,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      child: this.child,
      gestures: <Type, GestureRecognizerFactory>{
        AllowAllGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<AllowAllGestureRecognizer>(
                () => AllowAllGestureRecognizer(
                    onPanUpdate: this.onPanUpdate,
                    onPanDown: this.onPanDown,
                    onTap: this.onTap,
                    onPanEnd: this.onPanEnd,
                    onPanStart: this.onPanStart),
                (AllowAllGestureRecognizer instance) {})
      },
    );
  }
}
