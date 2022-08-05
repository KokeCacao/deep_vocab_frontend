
import 'package:flutter/material.dart';

class SearchBarListItem extends StatelessWidget {
  const SearchBarListItem({Key? key, required this.word,
    required this.callbackPressed, required this.color}) : super(key: key);

  final Color? color;
  final String word;
  final void Function() callbackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: color, //index % 2 == 0? Colors.grey[200]:Colors.grey[300],
      child: TextButton(
        onPressed: callbackPressed,
        child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(" > $word",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
              )
            ]
        ),
      ),
    );
  }
}