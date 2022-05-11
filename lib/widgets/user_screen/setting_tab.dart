import '../../utils/theme_data_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingTab extends StatefulWidget {
  final String? textFront;
  final IconData? icon;
  final String? textBack;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final VoidCallback? onButton;
  final bool buttonEnable;
  bool bottonValue;

  SettingTab(
      {this.textFront,
      this.icon,
      this.textBack,
      this.onPressed,
      this.onLongPressed,
      this.onButton,
      this.buttonEnable = false,
      this.bottonValue = true});

  @override
  State<StatefulWidget> createState() {
    return SettingTabState();
  }
}

class SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Provider.of<ThemeDataWrapper>(context, listen: false).tab,
          // border: BorderDirectional(
          //   top: BorderSide(
          //       width: 1,
          //       color: Provider.of<ThemeDataWrapper>(context, listen: false)
          //           .contrast),
          //   bottom: BorderSide(
          //       width: 1,
          //       color: Provider.of<ThemeDataWrapper>(context, listen: false)
          //           .contrast),
          // ),
      ),
      height: 60,
      width: double.infinity,
      child: TextButton(
        onPressed: widget.onPressed,
        onLongPress: widget.onLongPressed,
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
                  Icon(widget.icon),
                  Text("  ${widget.textFront}"),
                ],
              ),
              if (widget.buttonEnable)
                Switch.adaptive(
                    value: widget.bottonValue,
                    onChanged: (b) {
                      widget.bottonValue = !widget.bottonValue;
                      if (widget.onButton != null) widget.onButton!();
                      setState(() {});
                    })
              else
                Row(
                  children: [
                    Text(
                      "${widget.textBack}",
                      style: TextStyle(
                          color: Provider.of<ThemeDataWrapper>(context,
                                  listen: false)
                              .fadeTextColor),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color:
                          Provider.of<ThemeDataWrapper>(context, listen: false)
                              .fadeTextColor,
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
