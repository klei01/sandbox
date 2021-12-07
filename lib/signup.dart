import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'fire_auth.dart';

class signup extends StatefulWidget {
  const signup({Key key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 330.0, 0.0),
                    child: Container(
                      height: 15.0,
                      child: Text(
                        'NAME',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: Color.fromRGBO(40, 36, 69, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(40, 36, 69, 70),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 36, 69, 100)),
                            borderRadius: (BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 10.0, 330.0, 0.0),
                    child: Container(
                      height: 15.0,
                      child: Text(
                        'E-MAIL',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: Color.fromRGBO(40, 36, 69, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(40, 36, 69, 70),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 36, 69, 100)),
                            borderRadius: (BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 280.0, 0.0),
                    child: Container(
                      height: 15.0,
                      child: Text(
                        'PASSWORD',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: Color.fromRGBO(40, 36, 69, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(40, 36, 69, 70),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 36, 69, 100)),
                            borderRadius: (BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 265.0, 0.0),
                    child: Container(
                      height: 15.0,
                      child: Text(
                        'DATE OF BIRTH',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          color: Color.fromRGBO(40, 36, 69, 100),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 50.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(40, 36, 69, 70),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(40, 36, 69, 100)),
                            borderRadius: (BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => FireAuth.signUpWithEmail(
                          "turkuisi@gmail.com",
                          "sdkjlfn12412k",
                          "Isa Turku",
                          DateTime(2000, 16, 7, 0, 0, 0)),
                      child: Text('Sign up'),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(40, 36, 69, 10),
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
