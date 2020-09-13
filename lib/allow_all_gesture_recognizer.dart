import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AllowAllGestureRecognizer extends OneSequenceGestureRecognizer {
  final GestureTapCallback onTap;
  final GestureDragUpdateCallback onPanUpdate;
  final Function onPanEnd;
  final GestureDragDownCallback onPanDown;
  final GestureDragStartCallback onPanStart;
  Offset _startPosition;

  bool isPan = false;
  AllowAllGestureRecognizer(
      {this.onPanDown,
      this.onTap,
      this.onPanUpdate,
      this.onPanEnd,
      this.onPanStart})
      : super();
  @override
  String get debugDescription => 'allow all';

  @override
  void didStopTrackingLastPointer(int pointer) {}
  @override
  bool isPointerAllowed(PointerEvent event) {
    if (event.buttons != kPrimaryButton) {
      return false;
    }
    return super.isPointerAllowed(event as PointerDownEvent);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      bool initialPan = isPan;
      _checkIfPan(event);
      if (isPan) {
        if (initialPan == false) {
          if (onPanStart != null) {
            onPanStart(getDragStartDetails(event));
          }
        } else {
          if (onPanUpdate != null) {
            onPanUpdate(getDragUpdateDetails(event));
          }
        }
      }
    } else if (event is PointerUpEvent) {
      if (isPan) {
        if (onPanEnd != null) {
          onPanEnd(event.position);
        }
      } else {
        if (_startPosition != null && onTap != null) {
          onTap();
        }
      }
      stopTrackingPointer(event.pointer);
      _reset();
    } else if (event is PointerCancelEvent ||
        event is PointerExitEvent ||
        event is PointerRemovedEvent) {
      _reset();
    }
  }

  void _reset() {
    _startPosition = null;
    isPan = false;
  }

  bool _checkIfPan(PointerMoveEvent event) {
    if (!isPan) {
      isPan = (event.position - _startPosition).distance > kTouchSlop;
    }
    return isPan;
  }

  DragUpdateDetails getDragUpdateDetails(PointerMoveEvent event) {
    return DragUpdateDetails(
        delta: event.localDelta,
        sourceTimeStamp: event.timeStamp,
        localPosition: event.localPosition,
        globalPosition: event.position);
  }

  DragStartDetails getDragStartDetails(PointerMoveEvent event) {
    return DragStartDetails(
        globalPosition: event.position,
        localPosition: event.localPosition,
        sourceTimeStamp: event.timeStamp);
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    _startPosition = event.position;
    startTrackingPointer(event.pointer, event.transform);
    resolve(GestureDisposition.accepted);
    if (onPanDown != null) {
      onPanDown(DragDownDetails(
          globalPosition: event.position, localPosition: event.localPosition));
    }
  }
}
