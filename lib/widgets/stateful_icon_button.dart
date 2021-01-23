import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoStateButton extends StatefulWidget {
  final void Function() onPressed;
  bool value;
  final Icon trueIcon;
  final Icon falseIcon;

  TwoStateButton(
      {Key key,
      this.onPressed,
      @required this.trueIcon,
      @required this.falseIcon,
      this.value = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwoStateButtonState();
  }
}

class TwoStateButtonState extends State<TwoStateButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: widget.value ? widget.trueIcon : widget.falseIcon,
        onPressed: () {
          widget.value = !widget.value;
          if (widget.onPressed != null) widget.onPressed();
          setState(() {});
        });
  }
}
