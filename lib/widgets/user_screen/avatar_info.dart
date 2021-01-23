import 'package:deep_vocab/widgets/image_widget.dart';
import 'package:deep_vocab/widgets/user_screen/xp_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarInfo extends StatelessWidget {

  final double avatarRadius;
  final double borderRadius;
  final String avatarUrl;
  final String userName;
  final String uuid;
  final XpBar xpBar;

  AvatarInfo({this.avatarRadius, this.borderRadius, this.avatarUrl, this.userName, this.uuid, this.xpBar});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(double.infinity,
            2 * avatarRadius + 2 * borderRadius)), //width, height
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius)),
                  child: ImageWidget(
                    fit: BoxFit.cover,
                    height: 2 * avatarRadius,
                    width: 2 * avatarRadius,
                    imageUrl: avatarUrl,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text("UID: ${uuid.toString().split('-')[0]}"),
                    xpBar,
                  ],
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//              child:
            Icon(Icons.keyboard_arrow_right, size: avatarRadius),
//            )
          ],
        ));
  }

}