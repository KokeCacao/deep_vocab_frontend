import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabBadge extends StatelessWidget {
  final String? text;
  final IconData? icon;
  Color? color;

  VocabBadge({Key? key, this.text, this.icon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (color == null) color = Colors.blueGrey[700];
    return Badge(
      elevation: 0,
      animationType: BadgeAnimationType.scale,
      padding: EdgeInsets.all(4),
      badgeColor: Colors.blueGrey[100]!,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(2),
      badgeContent: icon == null
          ? Text(text!,
              style: TextStyle(
                  color: color, fontSize: 14, fontWeight: FontWeight.bold))
          : Icon(
              icon,
              color: color,
            ),
    );
  }
}
