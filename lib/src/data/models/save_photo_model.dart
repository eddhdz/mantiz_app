class SavePhotoModel {
  String uuidapp;
  String? uuid;
  String name;
  String type;
  String? url;
  String im64;
  DateTime createdAt;

  SavePhotoModel({
    required this.uuidapp,
    required this.uuid,
    required this.name,
    required this.type,
    required this.url,
    required this.im64,
    required this.createdAt,
  });

  factory SavePhotoModel.fromJson(Map<String, dynamic> json) {
    return SavePhotoModel(
      uuidapp: json['uuidapp'],
      uuid: (json['uuid'] != null) ? json['uuid'] : '',
      name: json['name'],
      type: json['type'],
      url: (json['url'] != null) ? json['url'] : '',
      im64: json['im64'],
      createdAt: DateTime.parse(json['createdAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'uuidapp': uuidapp,
        'uuid': uuid,
        'name': name,
        'type': type,
        'url': url,
        'im64': im64,
        'createdAt': createdAt.toIso8601String(),
      };
}
