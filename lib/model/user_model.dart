import 'package:bluecolorguy/model/portalmodel.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  final List<PortalModel>? portals;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.portals,
  });
}
