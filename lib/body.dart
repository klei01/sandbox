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
        margin: EdgeInsets.fromLTRB(10, 20, 10, 50),
        decoration: BoxDecoration(
            color: Colors.white70,
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
            Expanded(flex: 8, child: LineChartWidget())
          ],
        ),
      ),
    );
  }
}
