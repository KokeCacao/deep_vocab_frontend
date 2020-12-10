import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/models/user_model.dart';
import 'package:deep_vocab/utils/image_widget.dart';
import 'package:deep_vocab/utils/provider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UserScreen> {
  final double _avatarRadius = 40;
  final double _borderRadius = 4;
  final int _maxXp = 100;
  int _xp = 10;
  int _level = 19;
  String _avatarUrl = "http://via.placeholder.com/350x150";
  String _userName = "Koke_Cacao";
  var _uuid = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    Widget _xpBar = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("LV.${_level} "),
        Expanded(
          // for "double infinity" to work
          child: Container(
            height: 10,
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: _xp,
                  child: Container(
                    color: Colors.teal,
                  ),
                ),
                Expanded(
                  flex: _maxXp,
                  child: Container(
                    color: Colors.black12,
                  )),
              ],
            ),
          ),
        )
      ],
    );

    Widget _avatarInfo = ConstrainedBox(
        constraints: BoxConstraints.loose(Size(double.infinity,
            2 * _avatarRadius + 2 * _borderRadius)), //width, height
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  child: ImageWidget(
                    fit: BoxFit.cover,
                    height: 2 * _avatarRadius,
                    width: 2 * _avatarRadius,
                    imageUrl: _avatarUrl,
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
                        _userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text("UID: ${_uuid.toString().split('-')[0]}"),
                    _xpBar,
                  ],
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//              child:
            Icon(Icons.keyboard_arrow_right, size: _avatarRadius),
//            )
          ],
        ));

    Widget _provider = ProviderWidget<UserModel>(
      model: UserModel(), // to pass data so that we can call `UserModel` in builder directly
      child: Container(), // to give the builder its child
      builder: (context, oldModel, child) {
        print("[DEBUG] Starting output");
        print("[DEBUG] I got my username from old model ${oldModel.userName}");
        if (UserModel.user_model != null)
        print("[DEBUG] I got my username from user model ${UserModel.user_model.userName}");
        return child; // TODO: testing
      },
      onInitState: (model) {
        model.fetch(); // UserModel.fetch() on initState of Provider
      },
    );

    Widget _avatarCard = FlatButton(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _provider,
            _avatarInfo,
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

    Widget _buildSettings(
        {textFront = "",
        icon = Icons.hourglass_empty,
        textBack = "",
        onPressed = null}) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white60,
            border: BorderDirectional(
                top: BorderSide(width: 1, color: Colors.black12))),
        height: 60,
        width: double.infinity,
        child: FlatButton(
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon),
                    Text("  $textFront"),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${textBack}",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black54,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildSeparator() {
      return Container(
        height: 5,
        width: double.infinity,
        color: Colors.black12,
      );
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildSeparator(),
        _avatarCard,
        _buildSeparator(),
        _buildSettings(
            textFront: "学习设置",
            icon: Icons.settings,
            textBack: "",
            onPressed: () {}),
        _buildSettings(
            textFront: "深夜模式",
            icon: Icons.timelapse,
            textBack: "",
            onPressed: () {}),
        _buildSeparator(),
        _buildSettings(
            textFront: "提醒设置",
            icon: Icons.timer,
            textBack: "",
            onPressed: () {}),
        _buildSettings(
            textFront: "显示设置",
            icon: Icons.palette,
            textBack: "",
            onPressed: () {}),
        _buildSettings(
            textFront: "账号与安全",
            icon: Icons.security,
            textBack: "",
            onPressed: () {}),
        _buildSeparator(),
        _buildSettings(
            textFront: "统计设置",
            icon: Icons.timeline,
            textBack: "",
            onPressed: () {}),
        _buildSettings(
            textFront: "调教开发者",
            icon: Icons.developer_mode,
            textBack: "我也是学生党哦",
            onPressed: () {}),
        _buildSeparator(),
      ],
    );
  }
}
