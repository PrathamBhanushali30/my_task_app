import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String uid;

  UserModel({required this.email, required this.name, required this.uid,});

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "uid": uid,
  };

  static UserModel? fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapShot['email'],
      name: snapShot['name'],
      uid: snapShot['uid'],
    );
  }
}