import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandbox/text_flied.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db.dart';
import 'fire_auth.dart';

class login extends StatefulWidget {
  const login({Key key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.apps.first);
  @override
  void initState() {
    auth
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
    } else {
      print("object");
      Navigator.pushNamedAndRemoveUntil(context, "home",(_)=> false);
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 0.0),
                child: Container()),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Color.fromRGBO(40, 36, 69, 100),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 30.0),
              child: Container(
                child: Text(
                  'Sign in to continue',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(143, 142, 142, 100),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CustomTextField("E-MAIL", emailController, false),
            CustomTextField("PASSWORD", passwordController, true),
            Divider(
              height: 30.0,
              color: Colors.transparent,
            ),
            ElevatedButton(
                onPressed: () {
                  FireAuth.signinWithEmailAndPassword(emailController.text, passwordController.text,auth);
                  },
                child: Text('Log in'),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(40, 36, 69, 100),
                    padding: EdgeInsets.fromLTRB(140.0, 20.0, 140.0, 20.0),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "You dont have an account yet?",
                    style:
                        GoogleFonts.roboto(color: Colors.grey[600], fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "signup"),
                    child: Text(
                      "Sign Up.",
                      style: GoogleFonts.roboto(
                          color: Color.fromARGB(255, 40, 36, 69), fontSize: 18),
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
