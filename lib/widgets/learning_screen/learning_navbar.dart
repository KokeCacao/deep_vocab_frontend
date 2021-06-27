import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LearningNavbar extends StatelessWidget {

  final Function(int index)? onTabChange;
  final int? selectedIndex;
  final FSearchController? controller;

  const LearningNavbar({Key? key, this.onTabChange, this.selectedIndex, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (controller != null) Expanded(
          child: FSearch(
            controller: controller,
            center: false,
            height: 30.0,
            width: 200,
            corner: FSearchCorner.all(10),
            strokeColor: Colors.blueGrey,
            strokeWidth: 2.0,
            backgroundColor: Colors.white,
            cursorColor: Colors.blueGrey,
            cursorWidth: 4.0,
            cursorRadius: 2.0,
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.all(10),
            hints: ["搜索单词"],
            stopHintSwitchOnFocus: true,
            hintPrefix: Icon(Icons.search),
          ),
        ),
        GNav(
            curve: Curves.fastOutSlowIn, // tab animation curves
            duration: Duration(milliseconds: 400), // tab animation duration
            gap: 4, // the tab button gap between icon and text
            color: Colors.black12, // unselected icon color
            activeColor: Colors.blueGrey, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.blueGrey
                .withOpacity(0.1), // selected tab background color
            tabMargin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            padding: EdgeInsets.all(5), // navigation bar padding
            selectedIndex: selectedIndex!,
            onTabChange: onTabChange,
            tabs: [
              GButton(
                icon: Icons.alarm,
                text: "任务",
              ),
              GButton(
                icon: Icons.thumb_up,
                text: "已背",
              ),
              GButton(
                icon: Icons.book,
                text: "词表",
              ),
            ])
      ],
    );
  }
}
