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
      if (portalName != null) "name": portalName,
      if (portalUrl != null) "portalUrl": portalUrl,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }
}
