class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  final String? password;
  final String? conpassword;
  String? image;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.password,
    this.conpassword,
    this.image,
  });

  Map<String, Object?> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'image': '',
      };
  // static fromFireStore(Map<String, dynamic> data) {}
}
