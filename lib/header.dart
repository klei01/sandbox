import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:vibration/vibration.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin{
  BluetoothConnection connection;
  AudioCache _audioCache; 
  double leftValue = 0;
  double rightValue = 0;
  double value = 0;
  String rightLabel;
  String leftLabel;
  int weight = 0;
  int belastung = 0;
  String address;
  bool send;
  bool vibrate;
  bool sound;
  bool led;
  bool connected = false;
  Timer timer;
  List<double> weightData= [];
  Future<void> initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
     setState(() {
      weight = prefs.getInt("Weight") ?? 75;
      address = prefs.getString("connection") ?? "";
      belastung = prefs.getInt("Allowed Weight Bearing") ?? 20;
      vibrate = prefs.getBool("vibrate") ?? false;
      sound = prefs.getBool("sound") ?? false;
      led = prefs.getBool("led") ?? false;
      send = prefs.getBool("send") ?? false;
    });
  }
  Future<void> setPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    int pressure = await Database.getPressure();
    print("Pressure"+pressure.toString());
    int weight = await Database.getWeight();
    if(pressure != null && pressure != 0){
      prefs.setInt("Allowed Weight Bearing", pressure);
    }
    if(weight != null && weight != 0)
      prefs.setInt("Weight", weight);
  }
  
  void warnUser() async{
    if( value > 0.005 && value*100 < belastung && await Vibration.hasVibrator()){
      if(vibrate)
      Vibration.vibrate(pattern: [10, 100]);
      if(sound)
      _audioCache.play("beep_short.mp3");
    }
  }
  @override
  void initState() {
    print("initState");
    super.initState();
    setPrefs();
    _audioCache = AudioCache(
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
      FirebaseAuth.instanceFor(app: Firebase.apps.first)
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      if(connection != null)
        connection.close();
      Navigator.pushNamed(context,"login");
    } else {
    }
  });
  initPrefs().then((_) {
      bluetoothConnection();
      timer = Timer.periodic(new Duration(seconds: 30),(timer){
      double sum = 0;
      int count = 0;
      weightData.forEach((element) {
        if(element > 0.005){
        sum += element;
        count++;
        }
      });
      setState(() {                                                                   
        weightData = [];
      });
      if(connected){
        if(count == 0)
          Database.sendData(0);
        else
          Database.sendData((sum/count) ?? 0);
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
    initPrefs().then((_) async{
      if(send && connected){
        print("Sending...");
        if(led)
          connection.output.add(ascii.encode(weight.toString()+";"+ belastung.toString()));
        else
          connection.output.add(ascii.encode("0;0"));
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("send", false);
        send = false;
      }
    });
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
                        child:weight != null ? WeightIndicatorLeft(leftValue/(weight/2),leftLabel ?? "0",belastung) : WeightIndicatorLeft(0, "",belastung)
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child:weight != null ? WeightIndicatorRight(rightValue/(weight/2),rightLabel ?? "0",belastung) : WeightIndicatorRight(0, "",belastung)
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
      connection = await BluetoothConnection.toAddress(address);
      if(led)
          connection.output.add(ascii.encode(weight.toString()+";"+ belastung.toString()));
        else
          connection.output.add(ascii.encode("0;0"));
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
      warnUser();      
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