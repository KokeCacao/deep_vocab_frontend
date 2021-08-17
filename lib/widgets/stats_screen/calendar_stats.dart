import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarStatsModel {
  int black;
  int red;
  int yellow;
  int green;

  CalendarStatsModel(
      {required this.black,
      required this.red,
      required this.yellow,
      required this.green});

  get sum {
    return black + red + yellow + green;
  }
}

class CalendarStats extends StatefulWidget {
  final String mainText;
  final DateTime date;
  final List<CalendarStatsModel> calendarModels;

  CalendarStats(
      {required this.calendarModels,
      required this.mainText,
      required this.date}) {
    assert(this.calendarModels.length >= 7);
  }

  @override
  State<StatefulWidget> createState() => _CalendarStatsState();
}

class _CalendarStatsState extends State<CalendarStats> {
  int touchedIndex = -1;

  List<int> selectedSpots = [];
  FlDotSquarePainter? paint;

  void touchCallback(BarTouchResponse barTouchResponse) {
    setState(() {
      if (barTouchResponse.spot != null &&
          barTouchResponse.touchInput is! PointerUpEvent &&
          barTouchResponse.touchInput is! PointerExitEvent) {
        touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
      } else {
        touchedIndex = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BarChartData barChartData = BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            tooltipMargin: 4,
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (BarChartGroupData groupData, int groupIndex,
                BarChartRodData rodData, int rodIndex) {
              int index = groupData.x.toInt();
              List<String> date = List.generate(
                  7,
                  (index) =>
                      DateFormat.yMMMMd('en_US')
                          .format(widget.date.add(Duration(days: index))) +
                      '\n');
              return BarTooltipItem(
                date[index],
                TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "共 ${rodData.y.toInt().toString()} 单词",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: touchCallback,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'S';
              case 1:
                return 'M';
              case 2:
                return 'T';
              case 3:
                return 'W';
              case 4:
                return 'T';
              case 5:
                return 'F';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(
          7,
          (index) => makeGroupData(
              index,
              widget.calendarModels[index],
              widget.calendarModels
                      .reduce((value, element) =>
                          element.sum > value.sum ? element : value)
                      .sum
                      .toDouble() +
                  1.0,
              isTouched: index == touchedIndex)),
    );

    return AspectRatio(
      aspectRatio: 1.4, // height of calendar
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  widget.mainText,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${DateFormat.MMMMd().format(widget.date)} ~ ${DateFormat.MMMMd().format(widget.date.add(const Duration(days: 6)))}",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: BarChart(
                      barChartData,
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.blueGrey,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    CalendarStatsModel calendarModel,
    double maxValue, {
    bool isTouched = false,
    Color barColor = Colors.transparent, // when there is 1 in data, it will show background color
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    double runningSum = 0;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: calendarModel.sum.toDouble(),
          colors: isTouched ? [Colors.yellow] : [barColor],
          rodStackItems: [
            BarChartRodStackItem(
                runningSum, runningSum += calendarModel.green, Colors.green),
            BarChartRodStackItem(
                runningSum, runningSum += calendarModel.yellow, Colors.yellow),
            BarChartRodStackItem(
                runningSum, runningSum += calendarModel.red, Colors.red),
            BarChartRodStackItem(
                runningSum, calendarModel.sum.toDouble(), Colors.black),
          ],
          width: isTouched ? width + 5 : width,
          backDrawRodData: BackgroundBarChartRodData(
            // background
            show: true,
            y: max(10, maxValue),
            colors: [Colors.black12],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
