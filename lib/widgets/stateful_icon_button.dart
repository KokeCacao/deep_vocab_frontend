import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoStateButton extends StatefulWidget {
  final void Function(bool value)? onPressed;
  bool? value;
  final Icon trueIcon;
  final Icon falseIcon;
  final bool optimistic;

  TwoStateButton(
      {Key? key,
      this.onPressed,
      required this.trueIcon,
      required this.falseIcon,
      this.value = false,
      this.optimistic = false})
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
        icon: widget.value! ? widget.trueIcon : widget.falseIcon,
        onPressed: () {
          if (widget.onPressed != null) widget.onPressed!(!widget.value!);
          if (widget.optimistic) widget.value = !widget.value!;
          setState(() {});
        });
  }
}
