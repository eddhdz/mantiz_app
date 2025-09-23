import 'dart:convert';

// Modelo principal que mapea la respuesta completa de la API
class AssignedToResponseModel {
  final Response response;
  final List<Maintenance> maintenances;

  AssignedToResponseModel({
    required this.response,
    required this.maintenances,
  });

  factory AssignedToResponseModel.fromJson(Map<String, dynamic> json) {
    return AssignedToResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      maintenances: (json['maintenances'] as List<dynamic>)
          .map((item) => Maintenance.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// Clase para el objeto de respuesta general (con el ID y mensaje)
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

// Clase para cada elemento de la lista 'maintenances'
class Maintenance {
  final int id;
  final int fkMaintenance;
  final int asignedbyPartner;
  final WhoAssigned whoasigned; // El objeto anidado
  final int asignedToTechnician;
  final ToAssigned tosasigned; // El objeto anidado
  final DateTime estimedAt;
  final int active;

  Maintenance({
    required this.id,
    required this.fkMaintenance,
    required this.asignedbyPartner,
    required this.whoasigned,
    required this.asignedToTechnician,
    required this.tosasigned,
    required this.estimedAt,
    required this.active,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    // Decodifica el JSON anidado de 'whoasigned' que viene como un String
    final Map<String, dynamic> whoAssignedJson =
        jsonDecode(json['whoasigned'] as String) as Map<String, dynamic>;
    
    // Decodifica el JSON anidado de 'tosasigned' que viene como un String
    final Map<String, dynamic> toAssignedJson =
        jsonDecode(json['tosasigned'] as String) as Map<String, dynamic>;

    return Maintenance(
      id: json['id'] as int,
      fkMaintenance: json['fkMaintenance'] as int,
      asignedbyPartner: json['asignedbyPartner'] as int,
      whoasigned: WhoAssigned.fromJson(whoAssignedJson),
      asignedToTechnician: json['asignedToTechnician'] as int,
      tosasigned: ToAssigned.fromJson(toAssignedJson),
      estimedAt: DateTime.parse(json['estimedAt'] as String),
      active: json['active'] as int,
    );
  }
}

// Clase para el JSON del perfil del asignador (el contenido del campo anidado)
class WhoAssigned {
  final int idProfile;
  final String fullname;
  final String email;
  final String phone;
  final String userToken;
  final String typeUser;
  final String typeRole;

  WhoAssigned({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });

  factory WhoAssigned.fromJson(Map<String, dynamic> json) {
    return WhoAssigned(
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

// Clase para el JSON del perfil del asignado (el contenido del campo anidado)
class ToAssigned {
  final int idProfile;
  final String fullname;
  final String email;
  final String phone;
  final String userToken;
  final String typeUser;
  final String typeRole;

  ToAssigned({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });

  factory ToAssigned.fromJson(Map<String, dynamic> json) {
    return ToAssigned(
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