import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/db.dart';
import 'package:sandbox/settings.dart';
import 'package:sandbox/weightIndicatorLeft.dart';
import 'package:sandbox/weightIndicatorRight.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin{
  final prefs = SharedPreferences.getInstance();
  double leftValue = 0;
  double rightValue = 0;
  double value = 0;
  String rightLabel;
  String leftLabel;
  int weight;
  int belastung;
  String address;
  bool connected = false;
  Timer timer;
  List<double> weightData= [];
  Future<void> initPrefs() async {
    int pweight = await prefs.then((prefs) {
      return prefs.getInt("Gewicht") ?? 0;
    });
    String paddress = await prefs.then((prefs) {
      return prefs.getString("connection") ?? "";
    });
    int pbelastung = await prefs.then((prefs){
      return prefs.getInt("Erlaubte Belastung");
    });
     setState(() {
      weight = pweight;
      address = paddress;
      belastung = pbelastung;
    });
  }
  @override
  void initState() {
    super.initState();
      FirebaseAuth.instanceFor(app: Firebase.apps.first)
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      Navigator.pushNamed(context,"login");
    } else {
      print('User is signed in!');
    }
  });
  initPrefs().then((value) {
      bluetoothConnection();
      timer = Timer.periodic(new Duration(seconds: 30),(timer){
      double sum = 0;
      int count = 0;
      weightData.forEach((element) {
        sum += element;
        count++;
        
      });
      setState(() {                                                                   
        weightData = [];
      });
      if(connected){
        print("Value Sent: "+(sum/count).toString());
      Database.sendData(sum/count);
      }
    });
  });
  
  }

  @override
  void dispose() {
    super.dispose();
  }
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
                        child:weight != null ? WeightIndicatorLeft(leftValue/(weight/2),leftLabel ?? "0") : WeightIndicatorLeft(0, "")
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child:weight != null ? WeightIndicatorRight(rightValue/(weight/2),rightLabel ?? "0") : WeightIndicatorRight(0, "")
                      ),
                      Settings(),
                      Align(
                        alignment: Alignment.center,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 15,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 255, 0, 0),
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
                      ),
                      
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:!connected ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextButton(
                            child: Text("Connect",style: TextStyle(color: Colors.white),),
                            onPressed:(){ Navigator.pushNamed(context, "connection").then((value){
                              initPrefs().then((_){
                                bluetoothConnection();
                              });
                            });},),
                        ) : Text("Connected",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                      )
                    ],
                  ))
        );
  }
void bluetoothConnection() async {
  if (address != "") {
    try {
      BluetoothConnection connection = await BluetoothConnection.toAddress(address);
      connection.output.add(ascii.encode(weight.toString()+";"+belastung.toString()));
      connection.input.listen((event) {
          String data = utf8.decode(event);
          List<String> values = data.split(";");
          setState(() {
            leftValue = double.parse(values.first);
            rightValue = double.parse(values.last);
            leftLabel = double.parse(values.first).round().toString();
            rightLabel = double.parse(values.last).round().toString();
            value = (double.parse(values.first) + double.parse(values.last))/weight;
            weightData.add((double.parse(values.first) + double.parse(values.last))/weight);
          });
      }).onDone(() {
        setState(() {
          connected = connection.isConnected;
        });
      });
      setState(() {
        connected = true;
      });
      print("Connection: "+connection.isConnected.toString());
      
      print('Connected to the device');
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  } else {
    print("No device stored");
  }
}
}