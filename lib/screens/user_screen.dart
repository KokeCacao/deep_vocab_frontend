import 'dart:convert';

import 'package:deep_vocab/view_models/user_view_model.dart';
import 'package:deep_vocab/utils/provider_widget.dart';
import 'package:deep_vocab/widgets/avatar_card.dart';
import 'package:deep_vocab/widgets/avatar_info.dart';
import 'package:deep_vocab/widgets/separator.dart';
import 'package:deep_vocab/widgets/setting_tab.dart';
import 'package:deep_vocab/widgets/xp_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';

class UserScreen extends StatelessWidget {
  final int _maxXp = 100;
  final int _xp = 10;
  final int _level = 19;

  final double _avatarRadius = 40;
  final double _borderRadius = 4;
  final String _avatarUrl = "http://via.placeholder.com/350x150";
  final String _userName = "Koke_Cacao";
  final _uuid = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    print("[UserScreen] call build method");
    Widget _xpBar = XpBar(level: _level, xp: _xp, maxXp: _maxXp);

    Widget _avatarInfo = AvatarInfo(
        avatarRadius: _avatarRadius,
        borderRadius: _borderRadius,
        avatarUrl: _avatarUrl,
        userName: _userName,
        uuid: _uuid,
        xpBar: _xpBar);

    // Widget _graphqlProvider = Query(
    //   options: QueryOptions(
    //     documentNode: gql(r'''
    //         mutation {
    //             user(uuid: "038c4d22-4731-11eb-b378-0242ac130002", userName: "Koke_Cacao", xp: 1) {
    //                 uuid
    //                 userName
    //                 avatarUrl
    //                 xp
    //             }
    //         }
    //     '''),
    //     variables: {'page': 0},
    //   ),
    //   builder: (
    //     QueryResult result, {
    //     Refetch refetch,
    //     FetchMore fetchMore,
    //   }) {
    //     if (result.hasException) {
    //       print("[GraphQL] Exception! Result=${result.exception}");
    //       return Container();
    //     }
    //     if (result.loading && result.data == null) {
    //       print("[GraphQL] Loading initial data...");
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (result.loading && result.data != null) {
    //       print("[GraphQL] refreshing... Data = ${result.data}");
    //       return Container();
    //     }
    //
    //     print("[GraphQL] finished loading data. Data = ${result.data.data}");
    //     return Container();
    //   },
    // );

    Widget _provider = ProviderWidget<UserViewModel>(
      model:
          UserViewModel(), // to pass data so that we can call `UserModel` in builder directly.
      child:
          Container(), // to give the builder its child that doesn't need to be changed.
      builder: (context, model, child) {
        assert(model != null);
        if (model.userModel == null) print("[UserScreen] I got my username: NULL");
        else print("[UserScreen] I got my username: ${model.userModel.userName}");
        return child; // TODO: testing
      },
      onInitState: (model) {
        model.fetch(); // UserModel.fetch() on initState of Provider
      },
    );

    // ChangeNotifierProvider: can be at root, only Provider.of(context) rebuilds
    // if you can setting up multiple ChangeNotifierProvider, then it is impossible to set up on root because you can't build data there
    // when you create class for ChangeNotifierProvider, use `create` instead of `.value`
    // use `.value` when you have list???
    // ChangeNotifierProvider should be built where you fetch data

    // Provider.of(context) run build() called and when data change
    // Provider.of(context, listen: false) only run build() when build() call
    // Consumer can have child which is static

    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Separator(),
        AvatarCard(provider: _provider, avatarInfo: _avatarInfo),
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
