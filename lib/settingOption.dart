import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/dialogAction.dart';
import 'package:sandbox/settingTitle.dart';

class SettingOption extends StatelessWidget {
  final Icon icon;
  final String title;
  SettingOption(this.icon, this.title);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Color.fromARGB(255, 40, 36, 69),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SettingTitle(icon, title),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Aktuell : 85kg",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.white, width: 5))),
                            child: Row(
                              children: [
                                DialogAction("Cancel"),
                                DialogAction("OK")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SettingTitle(icon, title))),
    );
  }
}
