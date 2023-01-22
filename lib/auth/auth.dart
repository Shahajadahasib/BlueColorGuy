// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
    BuildContext context,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.code),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword(String username,
      String email, String password, BuildContext context) async {
    try {
      final UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('user')
          .doc(credential.user!.uid)
          .set(
        {
          "email": email,
          "username": username,
          "uid": credential.user!.uid,
        },
      );
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => const Homeviews(),
      //   ),
      //   (Route route) => false,
      // );
      Navigator.pop(context);
      return _userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.code),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  Future<void> deleteAccount() async {
    return await firebaseAuth.currentUser!.delete();
  }
}
