
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sandbox/lineChartWidget.dart';
import 'package:sandbox/timePeriodPicker.dart';

enum Period{
  hour,
  day
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Period range = Period.hour;
  String timePeriod = "Last Hour";
  DateTime selectedDate = DateTime.now();
  bool changed = false;
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
        firstDate: DateTime(1900, 1,1),
        lastDate: DateTime.now());
    if (picked != null ){
      setState(() {
        timePeriod = DateFormat.yMMMMd("en_US").format(picked);
        selectedDate = picked;
        changed = true;
        range = Period.day;
      });
    }
     
  }

  void changeTitle(String text, Period period) {
    setState(() {
      changed = false;
      range = period;
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
                    fontSize: 30,
                    color: Color.fromARGB(255, 40, 36, 69),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                flex: 1,
                child:
                    TimePeriodPicker(changeTitle, () => _selectDate(context))),
            Expanded(flex: 8, child: changed ? LineChartWidget(range,selectedDate) : LineChartWidget(range),
            )
          ],
        ),
      ),
    );
  }
}