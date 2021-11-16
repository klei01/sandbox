import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/weightIndicatorLeft.dart';
import 'package:sandbox/weightIndicatorRight.dart';

class Header extends StatelessWidget {
  final AnimationController controller;
  Header(this.controller);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
          padding: EdgeInsets.all(35),
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
