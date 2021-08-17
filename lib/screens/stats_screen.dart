import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/vocab_model.dart';
import '../view_models/vocab_list_view_model.dart';
import '../models/vocab_list_model.dart';
import '../widgets/stats_screen/percent_stats.dart';
import '../models/sub_models/mark_color_model.dart';
import '../widgets/stats_screen/calendar_stats.dart';

class StatsScreen extends StatefulWidget {

  final Color cardColor = Colors.white70;
  final double cardElevation = 0;
  final int howManyDays = 7;

  @override
  State<StatefulWidget> createState() {
    return _StatsScreenState();
  }
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Provider.of<VocabListViewModel>(context, listen: false).getFromDatabase(addedMark: true),
      builder: (BuildContext context, AsyncSnapshot<VocabListModel> snapshot) {
        if (snapshot.data == null || snapshot.data!.vocabs == null || snapshot.data!.vocabs!.isEmpty) return getEmpty();

        DateTime now = DateTime.now();
        List<CalendarStatsModel> calendarModels = List<CalendarStatsModel>.generate(widget.howManyDays, (i) => CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0)); // 7 day stats
        CalendarStatsModel totalModel = CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0); // total stats

        VocabListModel data = snapshot.data!;
        for (VocabModel vocab in data.vocabs!) {
          if (vocab.markColors != null && vocab.markColors!.last != null) {
            MarkColorModel color = vocab.markColors!.last!;

            // total stats
            switch(color.color!) {
              case ColorModel.black:
                totalModel.black++;
                break;
              case ColorModel.red:
                totalModel.red++;
                break;
              case ColorModel.yellow:
                totalModel.yellow++;
                break;
              case ColorModel.green:
                totalModel.green++;
                break;
            }

            // 7 days
            int diffDays = now.difference(color.time!).inDays; // calculated by timestamp
            if (diffDays < widget.howManyDays) {
              CalendarStatsModel thatDay = calendarModels[widget.howManyDays - 1 - diffDays];
              switch(color.color!) {
                case ColorModel.black:
                  thatDay.black++;
                  break;
                case ColorModel.red:
                  thatDay.red++;
                  break;
                case ColorModel.yellow:
                  thatDay.yellow++;
                  break;
                case ColorModel.green:
                  thatDay.green++;
                  break;
              }
            }

          } else {
            print("[StatsScreen] Warning: added vocab ${vocab.vocab} does not have MarkColor");
          }
        }

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: widget.cardColor,
                  elevation: widget.cardElevation,
                  child: CalendarStats(
                    calendarModels: calendarModels,
                    mainText: "本周单词统计",
                    date: DateTime.now(),
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: widget.cardColor,
                  elevation: widget.cardElevation,
                  child: PercentStats(
                    calendarStatsModel: totalModel,
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget getEmpty() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: widget.cardColor,
              elevation: widget.cardElevation,
              child: CalendarStats(
                calendarModels: [
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                  CalendarStatsModel(black: 0, red: 0, yellow: 0, green: 0),
                ],
                mainText: "本周单词统计",
                date: DateTime.now(),
              )),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: widget.cardColor,
              elevation: widget.cardElevation,
              child: PercentStats(
                calendarStatsModel:
                    CalendarStatsModel(black: 1, yellow: 1, green: 1, red: 1),
              )),
        ],
      ),
    );
  }
}
