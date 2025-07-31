import 'dart:convert';

class UserLicenceResponseModel {
  final Response response;
  final List<UserLicence> licences;

  UserLicenceResponseModel({
    required this.response,
    required this.licences,
  });

  factory UserLicenceResponseModel.fromJson(Map<String, dynamic> json) {
    return UserLicenceResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      // Map each item in the 'licences' list to a UserLicence object
      licences: (json['licences'] as List<dynamic>)
          .map((item) => UserLicence.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Response {
  final int id;
  final String msgSpa;

  Response({
    required this.id,
    required this.msgSpa,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'] as int,
      msgSpa: json['msgSpa'] as String,
    );
  }
}

class UserLicence {
  final int id;
  final int fkPartner;
  final String partner;
  final String uuidLicence;
  final int times;
  final LicenceDetails licenceDetails; // This will hold the parsed nested JSON
  final DateTime startAt;
  final DateTime endAt;
  final DateTime startNotifyAt;
  final String statusLicence;
  final DateTime createdAt;
  final int createdBy;
  final int active; // This is a 0 or 1, representing boolean

  UserLicence({
    required this.id,
    required this.fkPartner,
    required this.partner,
    required this.uuidLicence,
    required this.times,
    required this.licenceDetails,
    required this.startAt,
    required this.endAt,
    required this.startNotifyAt,
    required this.statusLicence,
    required this.createdAt,
    required this.createdBy,
    required this.active,
  });

  factory UserLicence.fromJson(Map<String, dynamic> json) {
    // --- Special handling for the nested 'licence' JSON string ---
    final String licenceJsonString = json['licence'] as String;
    final Map<String, dynamic> parsedLicenceMap = jsonDecode(licenceJsonString);
    final LicenceDetails licenceDetails =
        LicenceDetails.fromJson(parsedLicenceMap);
    // -----------------------------------------------------------------

    return UserLicence(
      id: json['id'] as int,
      fkPartner: json['fkPartner'] as int,
      partner: json['partner'] as String,
      uuidLicence: json['uuidLicence'] as String,
      times: json['times'] as int,
      licenceDetails: licenceDetails, // Use the parsed object
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      startNotifyAt: DateTime.parse(json['startNotifyAt'] as String),
      statusLicence: json['statusLicence'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as int,
      active: json['active'] as int,
    );
  }
}

// Model for the nested 'licence' JSON string
class LicenceDetails {
  final int id;
  final String uuidLicence;
  final int folio;
  final String licenceDescription; // Renamed from 'licence' to avoid conflict
  final String expirationTime;
  final int timeExpiration;
  final List<LicenceFilter> filters;

  LicenceDetails({
    required this.id,
    required this.uuidLicence,
    required this.folio,
    required this.licenceDescription,
    required this.expirationTime,
    required this.timeExpiration,
    required this.filters,
  });

  factory LicenceDetails.fromJson(Map<String, dynamic> json) {
    return LicenceDetails(
      id: json['id'] as int,
      uuidLicence: json['uuidLicence'] as String,
      folio: json['folio'] as int,
      licenceDescription: json['licence']
          as String, // Note: The field name is 'licence' in the JSON
      expirationTime: json['expirationtime'] as String,
      timeExpiration: json['timeexpiration'] as int,
      filters: (json['filters'] as List<dynamic>)
          .map((item) => LicenceFilter.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LicenceFilter {
  final int id;
  final String description;
  final int quantity;

  LicenceFilter({
    required this.id,
    required this.description,
    required this.quantity,
  });

  factory LicenceFilter.fromJson(Map<String, dynamic> json) {
    return LicenceFilter(
      id: json['id'] as int,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
    );
  }
}
