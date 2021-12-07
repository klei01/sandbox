import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandbox/body.dart';
import 'package:sandbox/header.dart';
import 'package:sandbox/login.dart';
import 'package:sandbox/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "home": (context) => MyHomePage(),
          "login": (context) => login(),
          "signup": (context) => signup()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        ),
        home: login()
        //MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Header(controller), Body()]));
  }
}
