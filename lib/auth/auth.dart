import 'package:bluecolorguy/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  // final usersdata = FirebaseFirestore.instance.collection("Users");
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  String? email, username, password, conpassword, uid, image;
  UserModel? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
      image: image,
    );
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map(
          (_userFromFirebase),
        );
  }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final creadential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel?> createUserWithEmailAndPassword(
    String username,
    String email,
    String password,

    // String? image,
  ) async {
    final credential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        FirebaseFirestore.instance.collection('User1').doc(value.user?.uid).set(
          {
            "email": value.user!.email,
            "username": username,
          },
        );
      },
    );

    return _userFromFirebase(credential.user);
  }

  Future<void> SignOut() async {
    return await _firebaseAuth.signOut();
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
