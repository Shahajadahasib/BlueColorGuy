import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favicon/favicon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/portalmodel.dart';

class DataProvider extends ChangeNotifier {
  addData({
    required PortalModel portalModel,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('portals')
        .add(portalModel.toFirestore());

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
