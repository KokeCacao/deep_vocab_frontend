import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcaseview.dart';

import '../utils/hive_box.dart';

class SingleShowcaseWrapper extends StatelessWidget {
  final Widget child;
  final String description;
  SingleShowcaseWrapper({required this.child, this.description = ""});

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    if (HiveBox.get(HiveBox.SHOWCASE_BOX, key.toString(), defaultValue: false)) {
      return child;
    } else {
      return ShowCaseWidget(
        builder: Builder(
          builder: (context) {
            WidgetsBinding.instance!.addPostFrameCallback(
                (_) => ShowCaseWidget.of(context).startShowCase([key]));
            return Showcase(key: key, child: child, description: description);
          },
        ),
        onComplete: (i, key) {
          HiveBox.put(HiveBox.SHOWCASE_BOX, key.toString(), true);
          return;
        },
      );
    }
  }
}

class WrappedShowcase extends StatelessWidget{
  final Widget child;
  final String description;
  WrappedShowcase({required this.child, this.description = ""});

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    List<GlobalKey> keys = HiveBox.get(HiveBox.SHOWCASE_BOX, "SHOWCASES", defaultValue: []);
    keys.add(key);
    HiveBox.put(HiveBox.SHOWCASE_BOX, "SHOWCASES", keys);

    return Showcase(child: child, description: description, key: key);
  }
}