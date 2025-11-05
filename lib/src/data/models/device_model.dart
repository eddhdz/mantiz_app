class DeviceModel {
  String deviceId;
  String name;
  String code;
  String barcode;
  String? typedevice;
  String? priority;
  String? levelpriority;
  int? rating;

  DeviceModel({
    required this.deviceId,
    required this.name,
    required this.code,
    required this.barcode,
    required this.typedevice,
    required this.priority,
    required this.levelpriority,
    required this.rating,
  });

  DeviceModel.init()
      : deviceId = '',
        name = '',
        code = '',
        barcode = '',
        typedevice = '',
        priority = '',
        levelpriority = '',
        rating = 0;

  // factory DeviceModel.fromJson(Map<String, dynamic> json) {
  //   return DeviceModel(
  //     deviceId: int.parse(json['deviceId'].toString()),
  //     name: json['name'],
  //     code: json['code'],
  //     barcode: json['barcode'],
  //     typedevice: json['typedevice'],
  //     priority: json['priority'],
  //     levelpriority: json['levelpriority'],
  //     rating: json['rating'],
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'deviceId': deviceId,
  //       'name': name,
  //       'code': code,
  //       'barcode': barcode,
  //       'typedevice': typedevice,
  //       'priority': priority,
  //       'levelpriority': levelpriority,
  //       'rating': rating,
  //     };
}
