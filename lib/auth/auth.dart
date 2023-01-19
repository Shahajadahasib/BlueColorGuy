import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class AuthService {
  // final usersdata = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? email, username, password, conpassword, uid, image;
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return UserModel(
      uid: user.uid,
      email: user.email,
    );
  }

  Stream<UserModel?>? get user {
    return firebaseAuth.authStateChanges().map(
          (_userFromFirebase),
        );
  }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final creadential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel?> createUserWithEmailAndPassword(
    String username,
    String email,
    String password,

    // String? image,
  ) async {
    final credential = await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set(
          {
            "email": value.user!.email,
            "username": username,
            "uid": value.user!.uid,
          },
        );
      },
    );

    return _userFromFirebase(credential.user);
  }

  Future<void> SignOut() async {
    return await firebaseAuth.signOut();
  }

  // Future<void> crateValue(
  //   String username,
  //   String uid,
  //   String email,
  // ) async {
  //   final usersdata = FirebaseFirestore.instance.collection(
  //       "Users"); //FirebaseFirestore.instance.collection(_firebaseAuth.currentUser!.uid);
  //   usersdata.add({
  //     'displayname': username,
  //     'uid': _firebaseAuth.currentUser!.uid,
  //     'email': email
  //   });
  //   return;
  // }
}
