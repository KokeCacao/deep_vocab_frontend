import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Axis axis;
  final double height;
  final double width;
  final Color color;
  Separator(
      {this.axis = Axis.horizontal,
      this.height = 5,
      this.width = 5,
      this.color = Colors.black12});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: axis == Axis.horizontal ? height : double.infinity,
      width: axis == Axis.horizontal ? double.infinity : width,
      color: color,
    );
  }
}
