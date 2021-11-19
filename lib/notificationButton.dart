import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {
  final dynamic activeIcon;
  final dynamic unactiveIcon;
  NotificationButton({this.activeIcon, this.unactiveIcon});
  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    var icon = active ? widget.activeIcon : widget.unactiveIcon;
    return Material(
      color: Color.fromARGB(255, 100, 77, 121),
      borderRadius: BorderRadius.circular(5),
      child: IconButton(
        onPressed: () {
          setState(() {
            active = !active;
          });
        },
        icon: icon,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        iconSize: 50,
      ),
    );
  }
}
