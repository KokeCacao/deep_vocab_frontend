import 'package:flutter/cupertino.dart';

class InitCallback extends StatelessWidget {
  final Future Function(BuildContext)? callBack;
  final Widget temporary;
  final Widget child;

  InitCallback({this.callBack, required this.temporary, required this.child});

  @override
  Widget build(BuildContext context) {
    if (callBack == null) return child;
    return FutureBuilder(
      future: this.callBack!(context),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return temporary;
        }
        return child;
      },
    );
  }
}
