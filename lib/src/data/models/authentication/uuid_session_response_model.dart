class UuidSessionResponseModel {
  final ResponseModel response;
  final List<SessionModel> sessions;

  UuidSessionResponseModel({
    required this.response,
    required this.sessions,
  });

  factory UuidSessionResponseModel.fromJson(Map<String, dynamic> json) {
    return UuidSessionResponseModel(
      response: ResponseModel.fromJson(json['response']),
      sessions: (json['sessions'] as List<dynamic>)
          .map((sessionJson) => SessionModel.fromJson(sessionJson))
          .toList(),
    );
  }
}

// Modelo para el objeto 'response'.
class ResponseModel {
  final int id;
  final String msgSpa;

  ResponseModel({
    required this.id,
    required this.msgSpa,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['id'],
      msgSpa: json['msgSpa'],
    );
  }
}

// Modelo para cada objeto 'session'.
class SessionModel {
  final SessionRoleModel partner;
  final SessionRoleModel? customer;
  final SessionRoleModel? supplier;

  SessionModel({
    required this.partner,
    required this.customer,
    required this.supplier,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      partner: SessionRoleModel.fromJson(json['partner']),
      customer: json['customer'] != null
          ? SessionRoleModel.fromJson(json['customer'])
          : null,
      supplier: json['supplier'] != null
          ? SessionRoleModel.fromJson(json['supplier'])
          : null,
    );
  }
}

// Modelo base para los objetos 'partner', 'customer', y 'supplier'.
class SessionRoleModel {
  final int fkPartner;
  final int fkPartnerLicence;
  final int? fkPartnerProfile;
  final int? fkCustomer;
  final String? customer;
  final int? fkCustomerProfile;
  final int? fkSupplier;
  final String? supplier;
  final int? fkSupplierProfile;
  final int fkProfile;
  final String typeuser;
  final String typerole;
  final ProfileModel profile;

  SessionRoleModel({
    required this.fkPartner,
    required this.fkPartnerLicence,
    this.fkPartnerProfile,
    this.fkCustomer,
    this.customer,
    this.fkCustomerProfile,
    this.fkSupplier,
    this.supplier,
    this.fkSupplierProfile,
    required this.fkProfile,
    required this.typeuser,
    required this.typerole,
    required this.profile,
  });

  factory SessionRoleModel.fromJson(Map<String, dynamic> json) {
    return SessionRoleModel(
      fkPartner: json['fkPartner'],
      fkPartnerLicence: json['fkPartnerLicence'],
      fkPartnerProfile: json['fkPartnerProfile'],
      fkCustomer: json['fkCustomer'],
      customer: json['customer'],
      fkCustomerProfile: json['fkCustomerProfile'],
      fkSupplier: json['fkSupplier'],
      supplier: json['supplier'],
      fkSupplierProfile: json['fkSupplierProfile'],
      fkProfile: json['fkProfile'],
      typeuser: json['typeuser'],
      typerole: json['typerole'],
      profile: ProfileModel.fromJson(json['profile']),
    );
  }
}

// Modelo para el objeto 'profile' común en los roles.
class ProfileModel {
  final String fullname;
  final String email;
  final String phone;

  ProfileModel({
    required this.fullname,
    required this.email,
    required this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
