
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/lineChartWidget.dart';
import 'package:sandbox/timePeriodPicker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String timePeriod = "Last Hour";
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: Color.fromARGB(255, 40, 36, 69),
              )),
              child: child);
        },
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
  }

  void changeTitle(String text) {
    setState(() {
      timePeriod = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                  color: Color.fromARGB(255, 40, 36, 69))
            ]),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                timePeriod,
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    color: Color.fromARGB(255, 40, 36, 69),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: 1,
                child:
                    TimePeriodPicker(changeTitle, () => _selectDate(context))),
            Expanded(flex: 8, child: LineChartWidget(),
            )
          ],
        ),
      ),
    );
  }
}
// StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection("data").where("time",isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(hours: 1))).orderBy("time",descending: true).snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Something went wrong');
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text("Loading");
//                 }else{
//                   List<FlSpot> spots= snapshot.data.docs.map((DocumentSnapshot document){
//                     Map<String, dynamic> data = document.data() as Map<String,dynamic>;
//                     Timestamp timestamp = data["time"] as Timestamp;
//                     DateTime time = timestamp.toDate();
//                     double value = data["value"] as double;
//                     FlSpot spot = FlSpot(time.minute.toDouble(), value);
//                     print(time.minute.toDouble().toString() +" "+ value.toString());
//                     return spot;
//                   }).toList();
//                   return LineChartWidget(spots);
//                 }
                
//               }
//             )