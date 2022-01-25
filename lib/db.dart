import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sandbox/fire_auth.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static sendData(double value){
    firestore.collection("data").add(
      {
        "value" : value != double.nan ? value : 0,
        "time" : FieldValue.serverTimestamp(),
        "uid"  : FirebaseAuth.instance.currentUser.uid != null ? FirebaseAuth.instance.currentUser.uid : "NA"
      }
    );
  }
}