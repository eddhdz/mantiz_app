// suspend_response_model.dart
import 'dart:convert';

// Main model for the complete API response
class SuspendResponseModel {
  final Response response;
  final List<Suspensions> maintenances;

  SuspendResponseModel({
    required this.response,
    required this.maintenances,
  });

  factory SuspendResponseModel.fromJson(Map<String, dynamic> json) {
    return SuspendResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      maintenances: (json['maintenances'] as List<dynamic>)
          .map((item) => Suspensions.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// Model for the general response status
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

// Model for the 'maintenances' list item
class Suspensions {
  final int id;
  final int fkMaintenance;
  final int? suspendByPartner;
  final dynamic suspendByCustomer; // Can be null
  final dynamic suspendBySupplier; // Can be null
  final WhoPartnerSuspend? whopartnersuspend;
  final dynamic whocustomersuspend; // Can be null
  final dynamic whosuppliersuspend; // Can be null
  final String reason;
  final DateTime suspendAt;
  final int active;

  Suspensions({
    required this.id,
    required this.fkMaintenance,
    required this.suspendByPartner,
    required this.suspendByCustomer,
    required this.suspendBySupplier,
    required this.whopartnersuspend,
    required this.whocustomersuspend,
    required this.whosuppliersuspend,
    required this.reason,
    required this.suspendAt,
    required this.active,
  });

  factory Suspensions.fromJson(Map<String, dynamic> json) {
    // Decode the nested JSON string for whopartnersuspend
    WhoPartnerSuspend? partnerSuspendData;
    if (json['whopartnersuspend'] != null) {
      final Map<String, dynamic> partnerJson =
          jsonDecode(json['whopartnersuspend'] as String)
              as Map<String, dynamic>;
      partnerSuspendData = WhoPartnerSuspend.fromJson(partnerJson);
    }

    return Suspensions(
      id: json['id'] as int,
      fkMaintenance: json['fkMaintenance'] as int,
      suspendByPartner: json['suspendByPartner'] as int?,
      suspendByCustomer: json['suspendByCustomer'],
      suspendBySupplier: json['suspendBySupplier'],
      whopartnersuspend: partnerSuspendData,
      whocustomersuspend: json['whocustomersuspend'],
      whosuppliersuspend: json['whosuppliersuspend'],
      reason: json['reason'] as String,
      suspendAt: DateTime.parse(json['suspendAt'] as String),
      active: json['active'] as int,
    );
  }
}

// Model for the 'whopartnersuspend' nested object
class WhoPartnerSuspend {
  final int idProfile;
  final String fullname;
  final String email;
  final String phone;
  final String userToken;
  final String typeUser;
  final String typeRole;

  WhoPartnerSuspend({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });

  factory WhoPartnerSuspend.fromJson(Map<String, dynamic> json) {
    return WhoPartnerSuspend(
      idProfile: json['idProfile'] as int,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      userToken: json['userToken'] as String,
      typeUser: json['typeUser'] as String,
      typeRole: json['typeRole'] as String,
    );
  }
}
