import 'package:mantiz/src/data/models/user_model.dart';

class AttendanceModel {
  String? atentionat;
  String? atentiontime;
  UserModel? asignedto;
  String? asignedat;
  String? estimatedtime;

  AttendanceModel({
    required this.atentionat,
    required this.atentiontime,
    required this.asignedto,
    required this.asignedat,
    required this.estimatedtime,
  });

  AttendanceModel.init()
      : atentionat = '',
        atentiontime = '',
        asignedto = UserModel.init(),
        asignedat = '',
        estimatedtime = '';

  // factory AttendanceModel.fromJson(Map<String, dynamic> json) {
  //   return AttendanceModel(
  //     atentionat: json['atentionat'],
  //     atentiontime: json['atentiontime'],
  //     asignedto: UserModel.fromJson(json['asignedto']),
  //     asignedat: json['asignedat'],
  //     estimatedtime: json['estimatedtime'],
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'atentionat': atentionat,
  //       'atentiontime': atentiontime,
  //       'asignedto': asignedto.toJson(),
  //       'asignedat': asignedat,
  //       'estimatedtime': estimatedtime,
  //     };
}
