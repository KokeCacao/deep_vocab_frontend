import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:deep_vocab/utils/constants.dart';
import 'package:deep_vocab/screens/learning_screen.dart';
import 'package:deep_vocab/screens/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'stats_screen.dart';

class NavigationScreen extends StatefulWidget {
  int pageIndex;

  NavigationScreen({this.pageIndex = 0}); // TODO: temporary value. should be 0

  @override
  State<StatefulWidget> createState() {
    return _NavigationScreenState();
  }
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'screen': LearningScreen(),
        'appBar_title': Constants.LEARNING_SCREEN_NAME,
      },
      {
        'screen': ExploreScreen(),
        'appBar_title': Constants.EXPLORE_SCREEN_NAME,
      },
      {
        'screen': StatsScreen(),
        'appBar_title': Constants.STATS_SCREEN_NAME,
      },
      {
        'screen': UserScreen(),
        'appBar_title': Constants.USER_SCREEN_NAME,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _screen = _pages[widget.pageIndex]['screen'];
    String _title = _pages[widget.pageIndex]['appBar_title'];

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

    // by extension BottomNavigationBarItemBadge
    // see https://github.com/westdabestdb/bottom_navigation_badge/issues/8
    _navItem = _badger.setBadge(_navItem, "1", 0);

    // TODO: try AnnotatedRegion<SystemUiOverlayStyle>
    // TODO: Hero animation
    // TODO: Sliver... SliverList, SliverGrid
    return Scaffold(
      appBar: _title == ""
          ? null
          : AppBar(
              title: Text(_title),
            ),
//      drawer: Drawer(),
      body: SafeArea(child: _screen),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.pageIndex,
          onTap: _setPages,
          items: _navItem),
    );
  }

  void _setPages(int i) {
    setState(() {
      widget.pageIndex = i;
    });
  }
}