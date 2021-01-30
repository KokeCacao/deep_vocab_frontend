import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/widgets/user_screen/avatar_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {

  final Widget avatarInfo;
  final VoidCallback onPressed;

  AvatarCard({this.avatarInfo, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarInfo,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: AutoSizeText(
                "我爱学习 学习使我快乐\n"
                    "我一天不学很深难受\n",
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

}