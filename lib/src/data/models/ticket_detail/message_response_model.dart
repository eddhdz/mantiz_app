import 'dart:convert';

// Modelo principal que mapea la respuesta completa de la API
class MessageResponseModel {
  final Response response;
  final List<Message> messages;

  MessageResponseModel({
    required this.response,
    required this.messages,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>)
          .map((item) => Message.fromJson(item as Map<String, dynamic>))
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

// Clase para cada elemento de la lista 'messages'
class Message {
  final int id;
  final int fkMaintenance;
  final int fkSender;
  final String body;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? removedAt;
  final String ticket;
  final int folio;
  final Profile profile; // El objeto anidado

  Message({
    required this.id,
    required this.fkMaintenance,
    required this.fkSender,
    required this.body,
    required this.createdAt,
    this.updatedAt,
    this.removedAt,
    required this.ticket,
    required this.folio,
    required this.profile,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    // Decodifica el JSON anidado en el campo 'profile' que viene como un String
    final Map<String, dynamic> profileJson =
        jsonDecode(json['profile'] as String) as Map<String, dynamic>;

    return Message(
      id: json['id'] as int,
      fkMaintenance: json['fkMaintenance'] as int,
      fkSender: json['fkSender'] as int,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      removedAt: json['removedAt'] != null
          ? DateTime.parse(json['removedAt'] as String)
          : null,
      ticket: json['ticket'] as String,
      folio: json['folio'] as int,
      profile: Profile.fromJson(profileJson),
    );
  }
}

// Clase para el JSON del perfil (el contenido del campo anidado)
class Profile {
  final int idProfile;
  final String fullname;
  final String email;
  final String phone;
  final String userToken;
  final String typeUser;
  final String typeRole;

  Profile({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
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
