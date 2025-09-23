import 'dart:convert';

// Modelo principal que mapea la respuesta completa de la API
class ScheduledResponseModel {
  final Response response;
  final List<Maintenance> maintenances;

  ScheduledResponseModel({
    required this.response,
    required this.maintenances,
  });

  factory ScheduledResponseModel.fromJson(Map<String, dynamic> json) {
    return ScheduledResponseModel(
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
  final int scheduledByPartner;
  final DateTime atentionAt;
  final int atentionTime;
  final WhoScheduled whoscheduled; // El objeto anidado
  final int active;

  Maintenance({
    required this.id,
    required this.fkMaintenance,
    required this.scheduledByPartner,
    required this.atentionAt,
    required this.atentionTime,
    required this.whoscheduled,
    required this.active,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    // Decodifica el JSON anidado de 'whoscheduled' que viene como un String
    final Map<String, dynamic> whoScheduledJson =
        jsonDecode(json['whoscheduled'] as String) as Map<String, dynamic>;
        
    return Maintenance(
      id: json['id'] as int,
      fkMaintenance: json['fkMaintenance'] as int,
      scheduledByPartner: json['scheduledByPartner'] as int,
      atentionAt: DateTime.parse(json['atentionAt'] as String),
      atentionTime: json['atentionTime'] as int,
      whoscheduled: WhoScheduled.fromJson(whoScheduledJson),
      active: json['active'] as int,
    );
  }
}

// Clase para el JSON del perfil del asignador (el contenido del campo anidado)
class WhoScheduled {
  final int idProfile;
  final String fullname;
  final String email;
  final String phone;
  final String userToken;
  final String typeUser;
  final String typeRole;

  WhoScheduled({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });

  factory WhoScheduled.fromJson(Map<String, dynamic> json) {
    return WhoScheduled(
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