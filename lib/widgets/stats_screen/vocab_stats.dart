import 'package:intl/intl.dart';

import '../../models/sub_models/mark_color_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class VocabStatsModel {
  DateTime x;
  double y;
  ColorModel color;

  VocabStatsModel({required this.x, required this.y, required this.color});

  get flSpot {
    return FlSpot(x.millisecondsSinceEpoch.toDouble(), y);
  }
}

class VocabStats extends StatefulWidget {
  final List<VocabStatsModel> vocabStatsModels;

  VocabStats({required this.vocabStatsModels});

  @override
  _VocabStatsState createState() => _VocabStatsState();
}

class _VocabStatsState extends State<VocabStats> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding:
            const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 20,
        verticalInterval: 86400000, // a day
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black12,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.black12,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval:
              86400000, // a day // TODO: using interval might be bad as data get large
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) => DateFormat.Md()
              .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
          margin: 8,
        ),
        leftTitles: SideTitles(
          interval: 20,
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => "${(value).toStringAsFixed(0)}\%",
          reservedSize: 28,
          margin: 12,
        ),
        rightTitles: SideTitles(
          interval: 20,
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => "${(value).toStringAsFixed(0)}\%",
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.black12, width: 1)),
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots:
              widget.vocabStatsModels.map((e) => e.flSpot as FlSpot).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: // TODO: implement gradient by color
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
