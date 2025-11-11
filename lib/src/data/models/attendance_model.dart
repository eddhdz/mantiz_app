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
        asignedto = UserModel.onInit(),
        asignedat = '',
        estimatedtime = '';
}
