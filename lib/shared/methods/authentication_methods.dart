import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred!';
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        UserModel userModel = UserModel(
          email: email,
          name: name,
          uid: user.user!.uid,
        );

        await _fireStore.collection('users').doc(user.user!.uid).set(userModel.toJson());
        result = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        result = 'email-already-in-use';
      } else {
        result = e.code;
      }
    }
    return result;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> logOutUser() async {
    String result = 'Some error occurred';
    try{
      await _auth.signOut();
      result = 'success';
    }catch(e){
      result = e.toString();
    }
    return result;
  }
}
