import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/main.dart';

class TimePeriodButton extends StatelessWidget {
  final String label;
  final Function changeTitle;
  TimePeriodButton(this.label, this.changeTitle);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
          onPressed: () => changeTitle(),
          child: Text(
            this.label,
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Color.fromARGB(255, 40, 36, 69),
              shape: StadiumBorder(),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              shadowColor: Color.fromARGB(255, 40, 36, 69),
              elevation: 5)),
    );
  }
}
