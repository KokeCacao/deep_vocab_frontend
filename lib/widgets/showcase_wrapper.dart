import 'package:flutter/widgets.dart';
import 'package:showcaseview/showcaseview.dart';

import '../utils/hive_box.dart';

class ShowcaseWrapper extends StatelessWidget {
  final GlobalKey
      showcaseKey; // The name must not be 'key' as it will confuse flutter
  final String description;
  final Widget child;

  ShowcaseWrapper(
      {required this.showcaseKey,
      required this.description,
      required this.child});

  @override
  Widget build(BuildContext context) {
    if (HiveBox.get(HiveBox.SHOWCASE_BOX, showcaseKey.toString(),
        defaultValue: false)) {
      return child;
    } else {
      return Showcase(
        key: showcaseKey,
        description: description,
        child: child,
      );
    }
  }
}
