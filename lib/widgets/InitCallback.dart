import 'package:flutter/cupertino.dart';

class InitCallback extends StatelessWidget {

  final void Function(BuildContext)? callBack;
  final Widget child;

  InitCallback({this.callBack, required this.child});

  @override
  Widget build(BuildContext context) {
    if (callBack != null) this.callBack!(context);
    // WidgetsBinding.instance!.addPostFrameCallback((_) => this.callBack!());

    return child;
  }
}