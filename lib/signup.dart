import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sandbox/text_flied.dart';

import 'fire_auth.dart';

class signup extends StatefulWidget {
  const signup({Key key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
          child: Text(
            'Create new Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50.0,
              color: Color.fromRGBO(40, 36, 69, 10),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'Already Registered?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(40, 36, 69, 100),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "login"),
              child: Text(
                'Log in.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromRGBO(40, 36, 69, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
        CustomTextField("NAME", nameController, false),
        CustomTextField("E-MAIL", emailController, false),
        CustomTextField("PASSWORD", passwordController, true),
        CustomTextField("BIRTHDAY", dobController, false),
        Divider(
          height: 30.0,
          color: Colors.transparent,
        ),
        ElevatedButton(
            onPressed: () => FireAuth.signUpWithEmail(
                emailController.text,
                passwordController.text,
                nameController.text,
                DateTime(2000, 15, 6, 0, 0, 0)),
            child: Text('Sign up'),
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(40, 36, 69, 10),
                padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      ],
    ));
  }
}
