import 'dart:math';

import 'package:flutter/material.dart';

class WeightIndicatorLeft extends StatefulWidget {
  double progress;
  String label;
  WeightIndicatorLeft(this.progress, this.label);
  @override
  createState() => WeightIndicatorLeftState();
}

class WeightIndicatorLeftState extends State<WeightIndicatorLeft> {
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 9,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
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
            Expanded(
              flex: 3,
              child: Transform.translate(
                offset: Offset(-5.0, 100),
                child: Container(
                  child: Row(children: [
                    Transform.rotate(
                        angle: pi,
                        child: Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: progressColor,
                        )),
                    Text(
                      percentage.toString() + "%",
                      style: TextStyle(color: progressColor),
                    )
                  ]),
                ),
              ),
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
