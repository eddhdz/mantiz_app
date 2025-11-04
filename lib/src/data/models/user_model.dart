import 'package:mantiz/src/data/models/user.dart';

class UserModel {
  String useruuid;
  String name;
  String email;
  String phone;

  UserModel({
    required this.useruuid,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel.init()
      : useruuid = '',
        name = '',
        email = '',
        phone = '';

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     useruuid: json['useruuid'],
  //     name: json['name'],
  //     email: json['email'],
  //     phone: json['phone'],
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'useruuid': useruuid,
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //     };
}
