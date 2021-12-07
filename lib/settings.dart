import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sandbox/notificationButton.dart';
import 'package:sandbox/settingOption.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              unactiveIcon:
                                  SvgPicture.asset("assets/vibrationoff.svg"),
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
    );
  }
}
