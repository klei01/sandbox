import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/notificationButton.dart';
import 'package:sandbox/settingOption.dart';
import 'package:sandbox/settings.dart';
import 'package:sandbox/weightIndicatorLeft.dart';
import 'package:sandbox/weightIndicatorRight.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
    return Expanded(
      flex: 4,
      child: Container(
          padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 40, 36, 69),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                    color: Color.fromARGB(255, 40, 36, 69))
              ]),
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
              Settings(),
              Align(
                alignment: Alignment.center,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 15,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(
                            (controller.value * 255).round(), 255, 0, 0),
                        shape: BoxShape.circle),
                  ),
                  Container(
                    width: 5,
                  ),
                  Text(
                    "LIVE",
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
