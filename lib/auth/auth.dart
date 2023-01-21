import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class AuthService {
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
  ) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return null;
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

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
