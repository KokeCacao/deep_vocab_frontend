import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  static const String routeName = '/explore_screen';

  @override
  State<StatefulWidget> createState() {
    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ExploreScreen"),
    );
  }
}
