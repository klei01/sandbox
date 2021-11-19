import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartWidget extends StatelessWidget {
  var spots = [
    FlSpot(5, 0),
    FlSpot(10, 35),
    FlSpot(15, 40),
    FlSpot(20, 22),
    FlSpot(25, 22),
    FlSpot(30, 35),
    FlSpot(35, 60),
    FlSpot(40, 22),
    FlSpot(45, 22),
    FlSpot(50, 35),
    FlSpot(55, 40),
    FlSpot(60, 22)
  ];
  String getTimeString(int min) {
    DateTime diff = DateTime.now().subtract(Duration(minutes: min));
    return diff.hour.toString() + ":" + diff.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
        child: LineChart(LineChartData(
          minX: 0,
          maxX: 60,
          minY: 0,
          maxY: 100,
          gridData:
              FlGridData(drawVerticalLine: true, drawHorizontalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
                showTitles: true,
                interval: 30,
                reservedSize: 10,
                getTitles: (value) {
                  if (value == 0) {
                    return getTimeString(60);
                  }
                  if (value == 30) {
                    return getTimeString(30);
                  }
                  if (value == 60) {
                    return getTimeString(0);
                  }
                  return "";
                },
                getTextStyles: (context, value) {
                  return TextStyle(color: Color.fromARGB(255, 40, 36, 69));
                }),
            leftTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 25,
                getTextStyles: (context, value) {
                  return TextStyle(color: Color.fromARGB(255, 40, 36, 69));
                }),
          ),
          lineTouchData: LineTouchData(
              getTouchedSpotIndicator: (barData, spotIndexes) {
                List<TouchedSpotIndicatorData> data = [];
                for (int a in spotIndexes) {
                  data.add(TouchedSpotIndicatorData(
                      FlLine(
                          color: Color.fromARGB(255, 40, 36, 69),
                          strokeWidth: 8),
                      FlDotData(getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                        color: Color.fromARGB(255, 40, 36, 69), radius: 8);
                  })));
                }
                return data;
              },
              touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Color.fromARGB(255, 40, 36, 69),
                  getTooltipItems: (tSpots) {
                    return tSpots.map((e) {
                      return LineTooltipItem(
                          e.y.toString(),
                          GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold));
                    }).toList();
                  })),
          lineBarsData: [
            LineChartBarData(
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(
                  show: false,
                ),
                gradientFrom: Offset(0, 1),
                gradientTo: Offset(0, 0),
                colorStops: [0.0, 0.25, 0.35],
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                    show: true,
                    colors: [
                      Colors.green.withOpacity(0.3),
                      Colors.orange.withOpacity(0.3),
                      Colors.red.withOpacity(0.3)
                    ],
                    gradientFrom: Offset(0, 1),
                    gradientTo: Offset(0, 0),
                    gradientColorStops: [0.0, 0.25, 0.35]),
                colors: [Colors.green, Colors.orange, Colors.red],
                spots: spots)
          ],
        )));
  }
}
