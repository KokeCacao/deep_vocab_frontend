import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme_data_wrapper.dart';

class LoginPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO
    // Cannot use expanded, see https://stackoverflow.com/questions/54905388/incorrect-use-of-parent-data-widget-expanded-widgets-must-be-placed-inside-flex
    // You should probably use Positioned.fill(key
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            color:
                Provider.of<ThemeDataWrapper>(context, listen: false).textColor,
            focusColor: Provider.of<ThemeDataWrapper>(context, listen: false)
                .highlightTextColor,
            hoverColor: Provider.of<ThemeDataWrapper>(context, listen: false)
                .fadeTextColor,
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.of(context).pushNamed("/login_screen");
            },
          ),
          Text("Please Log in first"),
        ],
      ),
    );
  }
}
