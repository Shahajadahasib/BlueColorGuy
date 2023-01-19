class UserModel {
  final String? uid;
  final String? email;
  final String? username;

  UserModel({
    this.uid,
    this.email,
    this.username,
  });

  Map<String, Object?> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
      };
}
