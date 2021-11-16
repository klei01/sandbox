import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/weightIndicatorLeft.dart';
import 'package:sandbox/weightIndicatorRight.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller2;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller2.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        flex: 6,
        child: Container(
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 40, 36, 69),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: WeightIndicatorLeft(controller.value, "Left"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: WeightIndicatorRight(0.3, "Right"),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 15,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(
                              (controller2.value * 255).round(), 255, 0, 0),
                          shape: BoxShape.circle),
                    ),
                    Container(
                      width: 5,
                    ),
                    Text(
                      "LIVE",
                      style: GoogleFonts.comfortaa(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                )
              ],
            )),
      ),
      Expanded(
        flex: 8,
        child: Container(),
      ),
    ]));
  }
}
