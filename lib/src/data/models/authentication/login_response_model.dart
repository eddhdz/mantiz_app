class LoginResponseModel {
  final ResponseModel response;
  final List<ProfileModel> profiles;

  LoginResponseModel({
    required this.response,
    required this.profiles,
  });

  // Factory constructor para crear una instancia del modelo desde un mapa JSON.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      response: ResponseModel.fromJson(json['response']),
      // Mapea la lista de JSON a una lista de objetos ProfileModel.
      profiles: (json['profiles'] as List)
          .map((profileJson) => ProfileModel.fromJson(profileJson))
          .toList(),
    );
  }

  // Método para convertir el modelo de vuelta a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'response': response.toJson(),
      'profiles': profiles.map((profile) => profile.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'msgSpa': msgSpa,
    };
  }
}

// Modelo para cada objeto 'profile' en la lista.
class ProfileModel {
  final int idProfile;
  final int fkUser;
  final int? fkCivilStatus;
  final int fkTypeUser;
  final int fkTypeRole;
  final String fullname;
  final String? genre;
  final String? civilstatus;
  final String? birthdate;
  final String? photo;
  final String email;
  final String phone;
  final String typeUser;
  final String userToken;
  final String username;
  final String typeRole;
  final int isActive;

  ProfileModel({
    required this.idProfile,
    required this.fkUser,
    this.fkCivilStatus,
    required this.fkTypeUser,
    required this.fkTypeRole,
    required this.fullname,
    this.genre,
    this.civilstatus,
    this.birthdate,
    this.photo,
    required this.email,
    required this.phone,
    required this.typeUser,
    required this.userToken,
    required this.username,
    required this.typeRole,
    required this.isActive,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      idProfile: json['idProfile'],
      fkUser: json['fkUser'],
      fkCivilStatus: json['fkCivilStatus'],
      fkTypeUser: json['fkTypeUser'],
      fkTypeRole: json['fkTypeRole'],
      fullname: json['fullname'],
      genre: json['genre'],
      civilstatus: json['civilstatus'],
      birthdate: json['birthdate'],
      photo: json['photo'],
      email: json['email'],
      phone: json['phone'],
      typeUser: json['typeUser'],
      userToken: json['userToken'],
      username: json['username'],
      typeRole: json['typeRole'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProfile': idProfile,
      'fkUser': fkUser,
      'fkCivilStatus': fkCivilStatus,
      'fkTypeUser': fkTypeUser,
      'fkTypeRole': fkTypeRole,
      'fullname': fullname,
      'genre': genre,
      'civilstatus': civilstatus,
      'birthdate': birthdate,
      'photo': photo,
      'email': email,
      'phone': phone,
      'typeUser': typeUser,
      'userToken': userToken,
      'username': username,
      'typeRole': typeRole,
      'isActive': isActive,
    };
  }
}
