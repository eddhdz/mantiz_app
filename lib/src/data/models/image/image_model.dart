import 'dart:convert';

class ImageResponseModel {
  final ResponseInfo response;
  final List<FileData> list;

  ImageResponseModel({
    required this.response,
    required this.list,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) {
    return ImageResponseModel(
      response: ResponseInfo.fromJson(json['response'] ?? {}),
      list: (json['list'] as List? ?? [])
          .map((item) => FileData.fromJson(item))
          .toList(),
    );
  }
}

class ResponseInfo {
  final int id;
  final String msgSpa;

  ResponseInfo({
    required this.id,
    required this.msgSpa,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      id: json['id'] ?? 0,
      msgSpa: json['msgSpa'] ?? '',
    );
  }
}

class FileData {
  final String uuid;
  final String uuidApp;
  final String name;
  final String type;
  final String url;
  final String fileBase64;

  FileData({
    required this.uuid,
    required this.uuidApp,
    required this.name,
    required this.type,
    required this.url,
    required this.fileBase64,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      uuid: json['uuid'] ?? '',
      uuidApp: json['uuidapp'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      fileBase64: json['file'] ?? '', // Aquí viene el string Base64
    );
  }

  // Helper para convertir el Base64 a bytes si necesitas mostrar la imagen
  List<int> get fileBytes => base64Decode(fileBase64.split(',').last);
}
