import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineChartWidget extends StatefulWidget {
  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final prefs = SharedPreferences.getInstance();
  double min;
  double max;
  String getTimeString(double time) { 
    Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(time.toInt());
    DateTime dateTime = timestamp.toDate();
    return DateFormat.Hm().format(dateTime);
  }
  int belastung = 0;
  Future<void> getValue() async {
    belastung = await prefs.then((prefs) {
      return prefs.getInt("Erlaubte Belastung") ?? 0;
    });
     setState(() {
      
    });
  }
  @override
  void initState() {
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("data").where("time",isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(hours: 1))).orderBy("time").snapshots(),
      builder: (context, snapshot) {
        List<FlSpot> spots = [];
        if(snapshot.hasError){
          return Container(
            child: Center(child: Text("An Error Ocurred",style: TextStyle(color: Colors.red),),),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 40, 36, 69),
              ),
            ),
          );
        }if(snapshot.hasData){
            spots = snapshot.data.docs.map((DocumentSnapshot doc){
              Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
              Timestamp timestamp =data["time"] as Timestamp;
              double value = data["value"] *100 as double;
              FlSpot spot = FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), value);
              return spot;
          }).toList();
              print("First: "+spots.first.x.toString());
              print("Last: "+spots.last.x.toString());
          return Container(
            padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: LineChart(LineChartData(
              minX: Timestamp.fromDate(DateTime.now().subtract(Duration(hours: 1))).millisecondsSinceEpoch.toDouble(),
              maxX: spots.last.x.toDouble() ,
              minY: 0,
              maxY: belastung != 0 ? belastung.toDouble() : 20,
              gridData:
                  FlGridData(drawVerticalLine: true, drawHorizontalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                    showTitles: true,
                    interval: 1800000,
                    reservedSize: 10,
                    getTitles: (value) {
                      return getTimeString(value);
                    },
                    getTextStyles: (context, value) {
                      return TextStyle(color: Color.fromARGB(255, 40, 36, 69));
                    }),
                leftTitles: SideTitles(
                    showTitles: true,
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
                          Colors.red.withOpacity(0.3),
                          Colors.orange.withOpacity(0.3),
                          Colors.green.withOpacity(0.3)
                        ],
                        gradientFrom: Offset(0, 1),
                        gradientTo: Offset(0, 0),
                        gradientColorStops: [0.0, 0.25, 0.35]),
                    colors: [Colors.red, Colors.orange, Colors.green],
                    spots: spots)
              ],
            )));
        }else{
          return Container(child: Center(child: Text("No data available for this time period."),),);
        }
        
      }
    );
  }
}
