import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MultiDismissibleStatus {
  ON_IDLE,
  ON_LEFT_EDGE,
  ON_MIDDLE_LEFT,
  ON_MIDDLE_RIGHT,
  ON_RIGHT_EDGE,
}

class MultiDismissible extends StatefulWidget {
  MultiDismissible({required this.child, this.dismissAnimation = false, required this.builder});

  Widget child;
  bool dismissAnimation;

  final Widget Function(Widget child, MultiDismissibleStatus status) builder;

  @override
  State<StatefulWidget> createState() {
    return MultiDismissibleState();
  }
}

class MultiDismissibleState extends State<MultiDismissible>
    with SingleTickerProviderStateMixin {
  late AnimationController _horizontalAnimationController;
  bool dismissed = false;
  double maxHorizontalSlide = 200.0; // or 200
  bool _canBeDragged = true;
  int _layerIndex = 0;

  @override
  void initState() {
    super.initState();
    _horizontalAnimationController = AnimationController(
        value: 0.5, vsync: this, duration: Duration(milliseconds: 200));
  }

  void _onDragStart(DragStartDetails dragStartDetails) {
    if (dismissed) _canBeDragged = false;
  }

  void _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double value = _horizontalAnimationController.value;
    if (_canBeDragged) {
      double damp = 10; // 5 or 1 without pow
      double divisor = pow((value - 0.5).abs() * 2, 2) * damp;
      divisor = divisor > 1 ? divisor : 1;

      _horizontalAnimationController.value +=
          (dragUpdateDetails.primaryDelta! / maxHorizontalSlide) / divisor;
    }
    int oldLayerIndex = _layerIndex;
    // 0 === 0.15 === 0.3 === 0.5 === 0.7 === 0.85 === 1
    if (value < 0.15)
      _layerIndex = 1;
    else if (value < 0.3)
      _layerIndex = 2;
    // else if (value < 0.5) _index = 0;
    else if (value < 0.7)
      _layerIndex = 0;
    else if (value < 0.85)
      _layerIndex = 3;
    else // < 1
      _layerIndex = 4;

    if (_layerIndex != oldLayerIndex){
      HapticFeedback.lightImpact();
    }
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    if (!_canBeDragged) return;
    // double value = _horizontalAnimationController.value;

    switch(_layerIndex) {
      case 0:
        widget.child = widget.builder(widget.child, MultiDismissibleStatus.ON_IDLE);
        backToSpace();
        break;
      case 1:
        widget.child = widget.builder(widget.child, MultiDismissibleStatus.ON_RIGHT_EDGE);
        widget.dismissAnimation ? dismissToLeft() : backToSpace();
        break;
      case 2:
        widget.child = widget.builder(widget.child, MultiDismissibleStatus.ON_MIDDLE_RIGHT);
        widget.dismissAnimation ? dismissToLeft() : backToSpace();
        break;
      case 3:
        widget.child = widget.builder(widget.child, MultiDismissibleStatus.ON_MIDDLE_LEFT);
        widget.dismissAnimation ? dismissToLeft() : backToSpace();
        break;
      case 4:
        widget.child = widget.builder(widget.child, MultiDismissibleStatus.ON_LEFT_EDGE);
        widget.dismissAnimation ? dismissToLeft() : backToSpace();
        break;
    }
  }

  void backToSpace() {
    _horizontalAnimationController.animateTo(0.5);
  }

  void dismissToLeft() {
    dismissed = true;
    maxHorizontalSlide = MediaQuery.of(context).size.width;
    _horizontalAnimationController.reverse();
  }

  void dismissToRight() {
    dismissed = true;
    maxHorizontalSlide = MediaQuery.of(context).size.width;
    _horizontalAnimationController.forward();
  }

  Widget buildBackground(TextDirection textDirection, Color backgroundColor,
      IconData icon, Color iconColor, double horizontalEdge, String text) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: double.infinity,
      height: 40, // same as VocabRow
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalEdge),
        child: Row(
          textDirection: textDirection,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                text,
                style: TextStyle(color: iconColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
          animation: _horizontalAnimationController,
          builder: (ctx, _) {
            return Stack(
              children: [
                IndexedStack(
                  index: _layerIndex,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40, // same as VocabRow
                      color: Colors.black12,
                    ),
                    buildBackground(TextDirection.rtl, Colors.green, Icons.done,
                        Colors.white, 8, "记忆正确"),
                    buildBackground(TextDirection.rtl, Colors.yellow, Icons.clear,
                        Colors.black, 8, "记忆混淆"),
                    buildBackground(TextDirection.ltr, Colors.red,
                        Icons.help_center_outlined, Colors.white, 10, "不知其意"),
                    buildBackground(TextDirection.ltr, Colors.black,
                        Icons.visibility_off_outlined, Colors.white, 10, "完全遗忘"),
                  ],
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(maxHorizontalSlide *
                        (_horizontalAnimationController.value * 2 -
                            1)), // need to be double
                  alignment: Alignment.center,
                  child: widget.child,
                ),
              ],
            );
          }),
    );
  }
}
