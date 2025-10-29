/// Modelo principal que encapsula la respuesta completa del JSON.
class LoginResponseModel {
  final ResponseModel response;
  final List<ListElementModel> list;

  LoginResponseModel({
    required this.response,
    required this.list,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      response: ResponseModel.fromJson(json['response']),
      list: (json['list'] as List<dynamic>)
          .map((itemJson) => ListElementModel.fromJson(itemJson))
          .toList(),
    );
  }
}

// -----------------------------------------------------------------------------
/// Modelo para el objeto 'response'.
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

// -----------------------------------------------------------------------------
/// Modelo para cada elemento dentro de la lista principal 'list'.
class ListElementModel {
  final ProfileModel profile;

  ListElementModel({
    required this.profile,
  });

  factory ListElementModel.fromJson(Map<String, dynamic> json) {
    return ListElementModel(
      profile: ProfileModel.fromJson(json['profile']),
    );
  }
}

// -----------------------------------------------------------------------------
/// Modelo para el objeto 'profile'.
class ProfileModel {
  final UserModel user;
  final MobileModel mobile;
  final List<PermissionModel> permissions;

  ProfileModel({
    required this.user,
    required this.mobile,
    required this.permissions,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserModel.fromJson(json['user']),
      mobile: MobileModel.fromJson(json['mobile']),
      permissions: (json['permissions'] as List<dynamic>)
          .map((permJson) => PermissionModel.fromJson(permJson))
          .toList(),
    );
  }
}

// -----------------------------------------------------------------------------
/// Modelo para el objeto 'user'.
class UserModel {
  final String useruuid;
  final String name;
  final String email;
  final String phone;
  final String typeuser;
  final String typerole;
  final int streaks;
  final String sessionAt;
  final int isActive;

  UserModel({
    required this.useruuid,
    required this.name,
    required this.email,
    required this.phone,
    required this.typeuser,
    required this.typerole,
    required this.streaks,
    required this.sessionAt,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      useruuid: json['useruuid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      typeuser: json['typeuser'],
      typerole: json['typerole'],
      streaks: json['streaks'],
      sessionAt: json['sessionAt'],
      isActive: json['isActive'],
    );
  }
}

// -----------------------------------------------------------------------------
/// Modelo para el objeto 'mobile'.
class MobileModel {
  final String uuid;
  final String firebasetoken;
  final int isAppActive;

  MobileModel({
    required this.uuid,
    required this.firebasetoken,
    required this.isAppActive,
  });

  factory MobileModel.fromJson(Map<String, dynamic> json) {
    return MobileModel(
      uuid: json['uuid'],
      firebasetoken: json['firebasetoken'],
      isAppActive: json['isAppActive'],
    );
  }
}

// -----------------------------------------------------------------------------
/// Modelo para los objetos dentro de la lista 'permissions'.
class PermissionModel {
  final int id;
  final String description;
  final int active;

  PermissionModel({
    required this.id,
    required this.description,
    required this.active,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'],
      description: json['description'],
      active: json['active'],
    );
  }
}