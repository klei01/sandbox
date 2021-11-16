import 'dart:math';

import 'package:flutter/material.dart';

class WeightIndicatorRight extends StatefulWidget {
  double progress;
  String label;
  WeightIndicatorRight(this.progress, this.label);
  @override
  createState() => WeightIndicatorRightState();
}

class WeightIndicatorRightState extends State<WeightIndicatorRight> {
  GlobalKey _widgetKey;
  @override
  Widget build(BuildContext context) {
    double progress = this.widget.progress;
    int percentage = (progress * 100).round();
    Color progressColor = progress >= 0.35
        ? Colors.red
        : progress >= 0.25
            ? Colors.orange
            : Colors.green;
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: 90,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
          flex: 9,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: Container(
                key: _widgetKey,
                height: double.infinity,
                child: Row(children: [
                  Text(
                    percentage.toString() + "%",
                    style: TextStyle(color: progressColor),
                  ),
                  Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: progressColor,
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(150, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.5,
                        )
                      ]),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 100 - percentage,
                          child: Container(
                            color: Colors.transparent,
                          )),
                      Expanded(
                          flex: percentage,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: progressColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.5,
                                  )
                                ]),
                          )),
                    ],
                  )),
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              this.widget.label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(5),
          ),
        )
      ]),
    );
  }
}
