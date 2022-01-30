import 'dart:math';

import 'package:flutter/material.dart';

class WeightIndicatorLeft extends StatefulWidget {
  final double progress;
  final String label;
  final int belastung;
  WeightIndicatorLeft(this.progress, this.label,this.belastung);
  @override
  createState() => WeightIndicatorLeftState();
}

class WeightIndicatorLeftState extends State<WeightIndicatorLeft> {
  GlobalKey _key = GlobalKey();
  double _height;
  void getHeight() {
    _height = _key.currentContext.size.height;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());
    double progress = this.widget.progress > 1 ? 1 : this.widget.progress ?? 0;
    progress = progress.isNaN  ? 0 : progress;
    int percentage = (progress * 100).round();
    Color progressColor = progress >= (widget.belastung+10)/100
        ? Colors.green
        : progress >= widget.belastung/100
            ? Colors.orange
            : Colors.red;
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: 95,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 9,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    decoration: BoxDecoration(
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
            ),
            Expanded(
              flex: 3,
              child: Transform.translate(
                offset: Offset(-5.0,
                    _height != null ? (_height / 2) - (_height * progress) : 0),
                child: Container(
                  height: double.infinity,
                  key: _key,
                  child: Row(children: [
                    Transform.rotate(
                        angle: pi,
                        child: Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: progressColor,
                        )),
                    Text(
                      widget.label + "kg",
                      style: TextStyle(
                          color: progressColor, fontWeight: FontWeight.bold),
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
              "Left",
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
