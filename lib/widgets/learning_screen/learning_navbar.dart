import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../utils/theme_data_wrapper.dart';
import '../../utils/showcase_manager.dart';
import '../showcase_wrapper.dart';

class LearningNavbar extends StatelessWidget {
  final Function(int index)? onTabChange;
  final int? selectedIndex;
  final Widget searchBar;
  // final FSearchController? controller;

  const LearningNavbar({
    Key? key,
    required this.searchBar,
    this.onTabChange,
    this.selectedIndex,
    // this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(child: searchBar),
        Expanded(
          child: ShowcaseWrapper(
            showcaseKey: ShowcaseManager.vocabBarShowcaseKey,
            description: "Switch between learned / unstudied vocab list",
            child: GNav(
                // TODO: Error. When [addPostFrameCallback] to [vocabBarShowcaseKey].
                // TODO: the below animation Duration after 400 ms will execute when the
                // TODO: widget is already disposed().
                // TODO: The preferred solution is to cancel the timer or stop listening
                // TODO: to the animation in the dispose() callback. Another solution is
                // TODO: to check the "mounted" property of this object before calling
                // TODO: setState() to ensure the object is still in the tree.
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
                    backgroundColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .tab,
                    iconColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .highlightTextColor,
                    rippleColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    iconActiveColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .textColor,
                  ),
                  GButton(
                    icon: Icons.thumb_up,
                    text: "已背",
                    backgroundColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .tab,
                    iconColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .highlightTextColor,
                    rippleColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    iconActiveColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .textColor,
                  ),
                  GButton(
                    icon: Icons.book,
                    text: "词表",
                    backgroundColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .tab,
                    iconColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .highlightTextColor,
                    rippleColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    iconActiveColor:
                        Provider.of<ThemeDataWrapper>(context, listen: false)
                            .textColor,
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
