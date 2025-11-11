class PhotoEvidenceModel {
  String uuid;
  String uuidapp;
  String name;
  String type;
  String? url;

  PhotoEvidenceModel({
    required this.uuid,
    required this.uuidapp,
    required this.name,
    required this.type,
    required this.url,
  });

  PhotoEvidenceModel.onInit()
      : uuid = '',
        uuidapp = '',
        name = '',
        type = '',
        url = null;

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'uuidapp': uuidapp,
        'name': name,
        'type': type,
        'url': url,
      };
}
