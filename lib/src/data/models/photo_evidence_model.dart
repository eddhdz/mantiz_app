class PhotoEvidenceModel {
  String uuid;
  String uuidapp;
  String name;
  String type;
  String url;

  PhotoEvidenceModel({
    required this.uuid,
    required this.uuidapp,
    required this.name,
    required this.type,
    required this.url,
  });

  factory PhotoEvidenceModel.fromJson(Map<String, dynamic> json) {
    return PhotoEvidenceModel(
      uuid: json['uuid'],
      uuidapp: json['uuidapp'],
      name: json['name'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'uuidapp': uuidapp,
        'name': name,
        'type': type,
        'url': url,
      };
}
