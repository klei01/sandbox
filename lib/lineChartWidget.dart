import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sandbox/body.dart';
import 'package:sandbox/fire_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineChartWidget extends StatefulWidget {
  final Period range;
  final DateTime initialDate;
  LineChartWidget(this.range,[this.initialDate]);
  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  double max;
  String getTimeString(double time) { 
    Timestamp timestamp = Timestamp.fromMillisecondsSinceEpoch(time.toInt());
    DateTime dateTime = timestamp.toDate();
    return DateFormat.Hm().format(dateTime);
  }
  int belastung = 0;
  Future<void> getValue() async {
  final prefs = await SharedPreferences.getInstance();
    belastung = prefs.getInt("Allowed Weight Bearing");
  }
  @override
  void initState() {
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
    getValue();
    double min;
    double max;
    Stream data;
    if(widget.initialDate !=null){
      DateTime date = widget.initialDate;
      min = Timestamp.fromDate(date).millisecondsSinceEpoch.toDouble();
      max = Timestamp.fromDate(DateTime(date.year,date.month,date.day,24,00)).millisecondsSinceEpoch.toDouble();
      data = FirebaseFirestore.instance.collection("data").where("uid",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("time",isGreaterThanOrEqualTo: DateTime.fromMillisecondsSinceEpoch(min.toInt())).where("time",isLessThanOrEqualTo: DateTime.fromMillisecondsSinceEpoch(max.toInt())).snapshots();
    }
    else{
      data = FirebaseFirestore.instance.collection("data").where("uid",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("time",isGreaterThanOrEqualTo: DateTime.now().subtract(widget.range == Period.hour ? Duration(hours: 1) : Duration(days: 1))).snapshots();
      min = Timestamp.fromDate(DateTime.now().subtract(widget.range == Period.hour ? Duration(hours: 1) : Duration(days: 1))).millisecondsSinceEpoch.toDouble();
      max = Timestamp.now().millisecondsSinceEpoch.toDouble();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: data,
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
              value = value.isFinite ? value : 0;
              FlSpot spot = FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), value);
              return spot;
          }).toList();
          if(spots.isEmpty){
            return Container(
              child: Center(child: Text("No data for this time period.",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 40, 36, 69)),),),
            );
          }
          return Container(
            padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: LineChart(LineChartData(
              minX: min,
              maxX: max ,
              minY: 0,
              maxY: 100,

              gridData:
                  FlGridData(drawVerticalLine: false, drawHorizontalLine: false,),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                    showTitles: true,
                    interval: widget.range == Period.hour ? 1800000 : 28800000,
                    reservedSize: 10,
                    getTitles: (value) {
                      return getTimeString(value);
                    },
                    getTextStyles: (context, value) {
                      return TextStyle(color: Color.fromARGB(255, 40, 36, 69));
                    }),
                leftTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
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
                              e.y.toStringAsFixed(2)+"%",
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
                    colorStops: [0.0, belastung/100 , (belastung+10)/100],
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
                        gradientColorStops: [0.0, belastung/100 , (belastung+10)/100]),
                    colors: [Colors.red, Colors.orange, Colors.green],
                    spots:  spots)
              ],
            )));
        }else{
          return Container(child: Center(child: Text("No data available for this time period."),),);
        }
        
      }
    );
  }
}
