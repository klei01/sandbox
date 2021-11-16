import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/timePeriodButton.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String timePeriod = "Last Hour";

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
            Text(
              timePeriod,
              style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Color.fromARGB(255, 40, 36, 69),
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 50,
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                      iconSize: 30,
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 40, 36, 69),
                      )),
                ),
                VerticalDivider(
                  color: Color.fromARGB(255, 40, 36, 69),
                  width: 5,
                  thickness: 3,
                ),
                Expanded(
                  flex: 8,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      TimePeriodButton(
                          "Last Hour", () => changeTitle("Last Hour")),
                      TimePeriodButton(
                          "Last Day", () => changeTitle("Last Day")),
                      TimePeriodButton(
                          "Last Week", () => changeTitle("Last Week")),
                      TimePeriodButton(
                          "Last Month", () => changeTitle("Last Month")),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
