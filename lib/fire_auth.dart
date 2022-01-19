import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static void signUpWithEmail(
      String email, String password, String name, DateTime dob) async {
        print(email);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((user) {
        _firestore
            .collection("User")
            .doc(user.user?.uid)
            .set({"name": name, "email": email, "dob": dob});
        user.user?.sendEmailVerification();
        return user;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> signinWithEmailAndPassword(String email, String password,FirebaseAuth auth) async{
    try{
      print(email);
      print(password);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
      );
    }on FirebaseAuthException catch (e){
      print(e.code);
      print("object");
      return false;
    }
    return true;
  }
}
