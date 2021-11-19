import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogAction extends StatelessWidget {
  final String title;
  DialogAction(this.title);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: title == "Cancel"
                    ? BorderSide(width: 2.5, color: Colors.white)
                    : BorderSide(),
                left: title == "OK"
                    ? BorderSide(width: 2.5, color: Colors.white)
                    : BorderSide(),
              )),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
