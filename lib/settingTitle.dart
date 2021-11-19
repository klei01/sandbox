import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingTitle extends StatelessWidget {
  final Icon icon;
  final String title;
  SettingTitle(this.icon, this.title);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      icon,
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          title,
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
