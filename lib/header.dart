import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/notificationButton.dart';
import 'package:sandbox/settingOption.dart';
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
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Color.fromRGBO(40, 36, 69, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) {
                        return Wrap(children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 50),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 10,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NotificationButton(
                                          activeIcon: Icon(
                                            Icons.volume_up_outlined,
                                          ),
                                          unactiveIcon: Icon(
                                            Icons.volume_off_outlined,
                                          )),
                                      NotificationButton(
                                          activeIcon: Icon(
                                            Icons.flashlight_on_outlined,
                                          ),
                                          unactiveIcon: Icon(
                                            Icons.flashlight_off_outlined,
                                          )),
                                      NotificationButton(
                                        activeIcon: Icon(
                                          Icons.vibration_outlined,
                                        ),
                                        unactiveIcon: SvgPicture.asset(
                                            "assets/vibrationoff.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                  thickness: 5,
                                  height: 50,
                                ),
                                SettingOption(
                                    Icon(Icons.monitor_weight_outlined,
                                        color: Colors.white, size: 30),
                                    "Gewicht"),
                                SettingOption(
                                    Icon(Icons.compress_outlined,
                                        color: Colors.white, size: 30),
                                    "Erlaubte Belastung"),
                                SettingOption(
                                    Icon(Icons.logout_outlined,
                                        color: Colors.white, size: 30),
                                    "Ausloggen"),
                              ],
                            ),
                          ),
                        ]);
                      },
                    );
                  },
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
