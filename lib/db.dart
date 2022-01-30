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
  static setWeight(int value){
    firestore.collection("User").doc(FirebaseAuth.instance.currentUser.uid).update({"gewicht":value});
  }
  static setPressure(int value){
    firestore.collection("User").doc(FirebaseAuth.instance.currentUser.uid).update({"belastung":value});
  }
  static int getWeight(){
    firestore.collection("User").doc(FirebaseAuth.instance.currentUser.uid).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        return snapshot.get("gewicht") ?? 0;
      }
    });
    return 0;
  }
  static int getPressure(){
    firestore.collection("User").doc(FirebaseAuth.instance.currentUser.uid).get().then((DocumentSnapshot snapshot){
      if(snapshot.exists){
        return snapshot.get("belastung") ?? 0;
      }
    });
    return 0;
  }
}