import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/db.dart';
import 'package:sandbox/settingTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDialog extends StatefulWidget {
  final Icon icon;
  final String title;
  EditDialog(
    this.icon,
    this.title,
  );
  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final _prefs = SharedPreferences.getInstance();
  final text = TextEditingController();
  bool _validate = false;
  int _value;
  Future<void> setValue(int value) async {
    final prefs = await _prefs;
    prefs.setInt(widget.title, value);
    prefs.setBool("send", true);
  }

  Future<void> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _value = (prefs.getInt(widget.title) ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Color.fromARGB(255, 40, 36, 69),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SettingTitle(widget.icon, widget.title),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
               widget.title == "Weight" ?"Aktuell : ${_value}kg" : "Aktuell : ${_value}%",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextField(
                controller: text,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    errorText: _validate ? "False Value" : null,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 5))),
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 2.5, color: Colors.white))),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Cancel",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 5,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (text.text.isEmpty) {
                              setState(() {
                                _validate = true;
                              });
                              return;
                            }
                            int value = int.parse(text.text);
                            setValue(value);
                            if(widget.title == "Weight"){
                              Database.setWeight(value);
                            }else{
                              Database.setPressure(value);
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 2.5, color: Colors.white))),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "OK",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
