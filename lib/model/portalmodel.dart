class PortalModel {
  final String portalName;
  final String portalUrl;
  final String phoneNumber;

  PortalModel({
    required this.portalName,
    required this.portalUrl,
    required this.phoneNumber,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "name": portalName,
      "portalUrl": portalUrl,
      "phoneNumber": phoneNumber,
    };
  }
}
