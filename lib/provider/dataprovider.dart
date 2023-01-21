import 'package:favicon/favicon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/portalmodel.dart';

class DataProvider extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;

  final List<PortalModel> _portals = [];
  List<PortalModel> get portals => _portals;

  addData({
    required PortalModel portalModel,
  }) {
    _portals.add(portalModel);
    // FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(firebaseAuth.currentUser!.uid);
    // log(portalName);
    // log(portalUrl);
    // log(phoneNumber);

    notifyListeners();
  }

  Future<String> getFavcicoUrl({required String url}) async {
    if (url.startsWith('https://')) {
      var iconUrl = await FaviconFinder.getBest(url);
      return iconUrl!.url;
    }
    final finalUrl = 'https://$url';
    var iconUrl = await FaviconFinder.getBest(finalUrl);
    return iconUrl!.url;
  }
}
