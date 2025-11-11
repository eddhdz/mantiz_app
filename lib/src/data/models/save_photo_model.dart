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

  SavePhotoModel.onInit()
      : uuidapp = '',
        uuid = '',
        name = '',
        type = '',
        url = null,
        im64 = '',
        createdAt = DateTime.now();
}
