import 'package:mantiz/src/data/models/device_model.dart';

class ZoneModel {
  String zone;
  int zoneId;
  List<DeviceModel> devices;

  ZoneModel({required this.zone, required this.devices, required this.zoneId});

  ZoneModel.onInit()
      : zone = '',
        zoneId = 0,
        devices = [];
}
