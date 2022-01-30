import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/editDialog.dart';
import 'package:sandbox/settingTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingOption extends StatefulWidget {
  final Icon icon;
  final String title;

  SettingOption(this.icon, this.title);

  @override
  State<SettingOption> createState() => _SettingOptionState();
}

class _SettingOptionState extends State<SettingOption> {
  final prefs = SharedPreferences.getInstance();

  int value = 0;
  Future<void> getValue() async {
    value = await prefs.then((prefs) {
      return prefs.getInt(widget.title) ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: widget.title == "Log Out"
              ? () {
               FirebaseAuth.instanceFor(app : Firebase.apps.first).signOut();
              }: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditDialog(widget.icon, widget.title);
                      });
                },
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SettingTitle(widget.icon, widget.title))),
    );
  }
}
