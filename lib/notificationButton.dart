import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationButton extends StatefulWidget {
  final dynamic activeIcon;
  final dynamic unactiveIcon;
  final String title;
  NotificationButton({this.activeIcon, this.unactiveIcon,this.title});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  bool active = true;
  toggle() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.title, !active);
    prefs.setBool("send",true);
    setState(() {
    active = !active;
    });
  }
  void initPrefs() async{
  final prefs = await SharedPreferences.getInstance();
    setState(() {
      active = prefs.getBool(widget.title) ?? false;
    });
  }
  @override
  void initState() {
    initPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var icon = active ? widget.activeIcon : widget.unactiveIcon;
    return Material(
      color: Color.fromARGB(255, 100, 77, 121),
      borderRadius: BorderRadius.circular(5),
      child: IconButton(
        onPressed: () => toggle(),
        icon: icon,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        iconSize: 50,
      ),
    );
  }
}
