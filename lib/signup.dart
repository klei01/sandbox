import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class signup extends StatefulWidget {
  const signup({Key key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
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
            child: Text(
              'Already Registered? Log in.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(40, 36, 69, 100),
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    borderSide:
                        BorderSide(color: Color.fromRGBO(40, 36, 69, 100)),
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
                    borderSide:
                        BorderSide(color: Color.fromRGBO(40, 36, 69, 100)),
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
                    borderSide:
                        BorderSide(color: Color.fromRGBO(40, 36, 69, 100)),
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
                    borderSide:
                        BorderSide(color: Color.fromRGBO(40, 36, 69, 100)),
                    borderRadius: (BorderRadius.circular(10.0))),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(40, 36, 69, 10),
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
