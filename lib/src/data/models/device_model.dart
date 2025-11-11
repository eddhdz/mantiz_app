import 'package:mantiz/src/data/models/failure_model.dart';

class DeviceModel {
  String deviceId;
  String name;
  String code;
  String barcode;
  String? typedevice;
  String? priority;
  String? levelpriority;
  int? rating;
  List<FailureModel> failures;

  DeviceModel(
      {required this.deviceId,
      required this.name,
      required this.code,
      required this.barcode,
      required this.typedevice,
      required this.priority,
      required this.levelpriority,
      required this.rating,
      required this.failures});

  DeviceModel.init()
      : deviceId = '',
        name = '',
        code = '',
        barcode = '',
        typedevice = '',
        priority = '',
        levelpriority = '',
        rating = 0,
        failures = [];
}
