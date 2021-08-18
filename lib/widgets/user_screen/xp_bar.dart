import 'package:flutter/material.dart';

class XpBar extends StatelessWidget {

  final int? level;
  final int? xp;
  final int? maxXp;

  XpBar({this.level, this.xp, this.maxXp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("LV.$level "),
        Expanded(
          // for "double infinity" to work
          child: Container(
            height: 10,
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: xp!,
                  child: Container(
                    color: Colors.teal,
                  ),
                ),
                Expanded(
                    flex: maxXp! - xp!,
                    child: Container(
                      color: Colors.black12,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }

}