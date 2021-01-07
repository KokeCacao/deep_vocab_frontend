import 'package:deep_vocab/models/user_model.dart';
import 'package:deep_vocab/view_models/auth_view_model.dart';
import 'package:deep_vocab/view_models/user_view_model.dart';
import 'package:deep_vocab/widgets/avatar_card.dart';
import 'package:deep_vocab/widgets/avatar_info.dart';
import 'package:deep_vocab/widgets/separator.dart';
import 'package:deep_vocab/widgets/setting_tab.dart';
import 'package:deep_vocab/widgets/xp_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UserScreen extends StatelessWidget {
  final int _maxXp = 100;
  final double _avatarRadius = 40;
  final double _borderRadius = 4;

  @override
  Widget build(BuildContext context) {
    // TODO: check memory leak when you create variables here (you need to call dispose)
    Widget _avatarInfo =
        Consumer<UserViewModel>(builder: (ctx, userViewModel, child) {
      if (userViewModel.userModel != null) {
        UserModel model = userViewModel.userModel;
        Widget _xpBar = XpBar(level: model.level, xp: model.xp, maxXp: _maxXp);

        return AvatarInfo(
            avatarRadius: _avatarRadius,
            borderRadius: _borderRadius,
            avatarUrl: model.avatarUrl == null
                ? "http://via.placeholder.com/350x150"
                : model.avatarUrl,
            userName: model.userName,
            uuid: model.uuid,
            xpBar: _xpBar);
      } else {
        // user not logged in
        Widget _xpBar = XpBar(level: 233, xp: _maxXp, maxXp: _maxXp);
        return AvatarInfo(
            avatarRadius: _avatarRadius,
            borderRadius: _borderRadius,
            avatarUrl: "http://via.placeholder.com/350x150",
            userName: "Click to Log in",
            uuid: "You have not logged in-",
            xpBar: _xpBar);
      }
    });

    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Separator(),
        AvatarCard(
          avatarInfo: _avatarInfo,
          onPressed: () {
            AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);
            if (!authViewModel.loggedIn()) Navigator.of(context).pushNamed("/login_screen");
            else authViewModel.logout();
          },
        ),
        Separator(),
        SettingTab(
            textFront: "学习设置",
            icon: Icons.settings,
            textBack: "",
            onPressed: () {}),
        SettingTab(
            textFront: "深夜模式",
            icon: Icons.timelapse,
            textBack: "",
            onPressed: () {}),
        Separator(),
        SettingTab(
            textFront: "提醒设置",
            icon: Icons.timer,
            textBack: "",
            onPressed: () {}),
        SettingTab(
            textFront: "显示设置",
            icon: Icons.palette,
            textBack: "",
            onPressed: () {}),
        SettingTab(
            textFront: "账号与安全",
            icon: Icons.security,
            textBack: "",
            onPressed: () {}),
        Separator(),
        SettingTab(
            textFront: "统计设置",
            icon: Icons.timeline,
            textBack: "",
            onPressed: () {}),
        SettingTab(
            textFront: "调教开发者",
            icon: Icons.developer_mode,
            textBack: "我也是学生党哦",
            onPressed: () {}),
        Separator(),
      ],
    );
  }
}