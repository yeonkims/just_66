import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:just66/data/models/graph_point.dart';

class LineProgress extends StatefulWidget {
  LineProgress({Key? key, required this.graphPoints}) : super(key: key);
  List<GraphPoint> graphPoints;

  @override
  _LineProgressState createState() => _LineProgressState();
}

class _LineProgressState extends State<LineProgress> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xffe6e6e6)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            if (value == _getMaxX() / 2) {
              return 'Time';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value == _getMaxY()) {
              return '${_getMaxY().toInt()}';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: _getMaxX(),
      minY: 0,
      maxY: _getMaxY(),
      lineBarsData: [
        LineChartBarData(
          spots: drawSpots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> get drawSpots {
    final spots = widget.graphPoints.map((gp) {
      DateTime xZeroDate =
          DateTime.now().subtract(Duration(days: _getMaxX().toInt() + 1));
      double xPostion = gp.recordDate.difference(xZeroDate).inDays.toDouble();
      return FlSpot(xPostion, gp.totalRecords.toDouble());
    }).toList();
    return spots;
  }

  double _getMaxX() {
    return widget.graphPoints.length.toDouble() - 1;
  }

  double _getMaxY() {
    double maxY = -1;

    widget.graphPoints.forEach((gp) {
      if (gp.totalRecords > maxY) {
        maxY = gp.totalRecords.toDouble();
      }
    });

    return maxY;
  }
}
