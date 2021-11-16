import 'dart:math';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
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
            padding: EdgeInsets.all(30),
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
