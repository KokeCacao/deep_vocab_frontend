import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme_data_wrapper.dart';

class LoginPrompt extends StatelessWidget {
  LoginPrompt();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: Provider.of<ThemeDataWrapper>(context, listen: false)
                  .textColor,
              focusColor:
              Provider.of<ThemeDataWrapper>(context, listen: false)
                  .highlightTextColor,
              hoverColor:
              Provider.of<ThemeDataWrapper>(context, listen: false)
                  .fadeTextColor,
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.of(context).pushNamed("/login_screen");
              },
            ),
            Text("Please Log in first"),
          ],
        ),
      ),
    );
  }
}
