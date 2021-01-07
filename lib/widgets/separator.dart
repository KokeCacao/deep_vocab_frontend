import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double height;
  final Color color;
  Separator({this.height = 5, this.color = Colors.black12});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
    );
  }
}
