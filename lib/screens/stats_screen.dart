import '../widgets/stats_screen/percent_stats.dart';
import '../models/sub_models/mark_color_model.dart';
import '../widgets/stats_screen/calendar_stats.dart';
import '../widgets/stats_screen/vocab_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {

    Color cardColor = Colors.white70;
    double cardElevation = 0;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: cardColor,
              elevation: cardElevation,
              child: CalendarStats(
                calendarModels: [
                  CalendarStatsModel(black: 12, red: 3, yellow: 7, green: 6),
                  CalendarStatsModel(black: 8, red: 4, yellow: 0, green: 0),
                  CalendarStatsModel(black: 2, red: 1, yellow: 3, green: 8),
                  CalendarStatsModel(black: 9, red: 3, yellow: 7, green: 6),
                  CalendarStatsModel(black: 8, red: 3, yellow: 3, green: 8),
                  CalendarStatsModel(black: 2, red: 1, yellow: 2, green: 10),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                ],
                mainText: "本周单词统计",
                date: DateTime.now(),
              )),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: cardColor,
              elevation: cardElevation,
              child: VocabStats(
                vocabStatsModels: [
                  VocabStatsModel(
                      x: DateTime(2020, 7, 17, 06, 49),
                      y: 87.1,
                      color: ColorModel.black),
                  VocabStatsModel(
                      x: DateTime(2020, 7, 17, 07, 20),
                      y: 37.398,
                      color: ColorModel.red),
                  VocabStatsModel(
                      x: DateTime(2020, 7, 17, 21, 36),
                      y: 84.2,
                      color: ColorModel.green),
                  VocabStatsModel(
                      x: DateTime(2020, 7, 18, 03, 29),
                      y: 92.8219,
                      color: ColorModel.red),
                  VocabStatsModel(
                      x: DateTime(2020, 7, 19, 03, 29),
                      y: 95.8219,
                      color: ColorModel.yellow),
                ],
              )),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: cardColor,
              elevation: cardElevation,
              child: PercentStats(
                calendarStatsModel:
                    CalendarStatsModel(black: 3, yellow: 0, green: 10, red: 4),
              )),
        ],
      ),
    );
  }
}
