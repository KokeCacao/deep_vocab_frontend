import 'package:deep_vocab/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/view_models/http_sync_view_model.dart';
import '/screens/learning_screen.dart';
import '/screens/user_screen.dart';
import 'explore_screen.dart';
import 'stats_screen.dart';

class NavigationScreen extends StatefulWidget {

  // This way NavigationScreen() class won't rebuild
  // because of [child] property on [Consumer()], so change dark mode will preserve state
  bool init = true;
  int pageIndex = 0;

  NavigationScreen(); // TODO: temporary value. should be 0

  @override
  State<StatefulWidget> createState() {
    return _NavigationScreenState();
  }
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.init) {
      Util.checkForUpdate(context);
      widget.init = false;
    }

    BottomNavigationBadge _badger = new BottomNavigationBadge(
        backgroundColor: Colors.red,
        badgeShape: BottomNavigationBadgeShape.circle,
        textColor: Colors.white,
        position: BottomNavigationBadgePosition.topRight,
        textSize: 8);

    List<BottomNavigationBarItem> _navItem = [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.book,
            color: Colors.black54,
          ),
          label: Constants.NAVIGATION_LEARNING_LABEL),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.explore,
          color: Colors.black54,
        ),
        label: Constants.NAVIGATION_EXPLORE_LABEL,
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart,
            color: Colors.black54,
          ),
          label: Constants.NAVIGATION_STATS_LABEL),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: Colors.black54,
          ),
          label: Constants.NAVIGATION_USER_LABEL),
    ];

    // TODO: it will be great if this call to ChangeNotifierProvider does not refresh the whole widget
    int badgeNumber = Provider.of<HttpSyncViewModel>(context, listen: true)
        .navigationLearningBadgeCount;
    if (badgeNumber > 0) {
      _navItem = _badger.setBadge(_navItem, badgeNumber.toString(), 0);
    }

    // TODO: try AnnotatedRegion<SystemUiOverlayStyle>
    // TODO: Hero animation
    // TODO: Sliver... SliverList, SliverGrid
    return Scaffold(
      appBar: null,
//      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.pageIndex,
          onTap: _setPages,
          items: _navItem),
      body: SafeArea(
          child: Stack(
        children: [
          // [Offstage] is used to keep state of every tab
          Offstage(
            offstage: widget.pageIndex != 0,
            child: LearningScreen(),
          ),
          Offstage(
            offstage: widget.pageIndex != 1,
            child: ExploreScreen(),
          ),
          Offstage(
            offstage: widget.pageIndex != 2,
            child: StatsScreen(),
          ),
          Offstage(
            offstage: widget.pageIndex != 3,
            child: UserScreen(),
          ),
        ],
      )),
    );
  }

  void _setPages(int i) {
    setState(() {
      widget.pageIndex = i;
    });
  }
}
