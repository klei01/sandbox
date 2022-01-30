
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandbox/DiscoverPage.dart';
import 'package:sandbox/body.dart';
import 'package:sandbox/firebase_options.dart';
import 'package:sandbox/header.dart';
import 'package:sandbox/login.dart';
import 'package:sandbox/signup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "home": (context) => MyHomePage(),
          "login": (context) => login(),
          "signup": (context) => signup(),
          "connection" :(context) => DiscoveryPage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        ),
        home: login()
        );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Header(), Body()]));
  }
}
