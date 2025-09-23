import 'dart:convert';

// Modelo principal que mapea la respuesta completa de la API
class ProfileResponseModel {
  final Response response;
  final List<ProfileData> profiles;

  ProfileResponseModel({
    required this.response,
    required this.profiles,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      profiles: (json['profiles'] as List<dynamic>)
          .map((item) => ProfileData.fromJson(item as Map<String, dynamic>))
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

// Clase para cada elemento de la lista 'profiles'
class ProfileData {
  final int id;
  final int fkSBO;
  final int fkProfile;
  final String uuidProfile;
  final String typeuser;
  final String typerole;
  final Profile profile; // El objeto anidado

  ProfileData({
    required this.id,
    required this.fkSBO,
    required this.fkProfile,
    required this.uuidProfile,
    required this.typeuser,
    required this.typerole,
    required this.profile,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    // Decodifica el JSON anidado en el campo 'profile' que viene como un String
    final Map<String, dynamic> profileJson =
        jsonDecode(json['profile'] as String) as Map<String, dynamic>;

    return ProfileData(
      id: json['id'] as int,
      fkSBO: json['fkSBO'] as int,
      fkProfile: json['fkProfile'] as int,
      uuidProfile: json['uuidProfile'] as String,
      typeuser: json['typeuser'] as String,
      typerole: json['typerole'] as String,
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
