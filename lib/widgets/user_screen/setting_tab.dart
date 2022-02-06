import '../../utils/theme_data_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingTab extends StatelessWidget {
  final String? textFront;
  final IconData? icon;
  final String? textBack;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  SettingTab({this.textFront, this.icon, this.textBack, this.onPressed, this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Provider.of<ThemeDataWrapper>(context, listen: false).tab,
          border: BorderDirectional(
              top: BorderSide(width: 1, color: Provider.of<ThemeDataWrapper>(context, listen: false).blackContrast))),
      height: 60,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
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
                    "$textBack",
                    style: TextStyle(color: Provider.of<ThemeDataWrapper>(context, listen: false).fadeTextColor),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Provider.of<ThemeDataWrapper>(context, listen: false).fadeTextColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
