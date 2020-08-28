import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  static const String routeName = '/stats_screen';

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Stats Screen"),
    );
  }
}
