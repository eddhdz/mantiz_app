// Modelo principal que mapea la respuesta completa de la API
class AddMessageResponseModel {
  final Response response;

  AddMessageResponseModel({
    required this.response,
  });

  factory AddMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return AddMessageResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
    );
  }
}

// Clase para el objeto de respuesta general (con el ID y mensaje)
class Response {
  final int id;
  final String msgSpa;

  Response({
    required this.id,
    required this.msgSpa,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'] as int,
      msgSpa: json['msgSpa'] as String,
    );
  }
}