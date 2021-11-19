import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class login extends StatefulWidget {
  const login({Key key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 0.0),
            child: Image.asset('assets/KNEEH.png'),
          ),
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
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 330.0, 0.0),
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
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 280.0, 0.0),
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
              child: Text('Log in'),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(40, 36, 69, 100),
                  padding: EdgeInsets.fromLTRB(140.0, 20.0, 140.0, 20.0),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
