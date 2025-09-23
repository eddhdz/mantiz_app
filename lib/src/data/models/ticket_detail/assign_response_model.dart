// Modelo principal que mapea la respuesta completa de la API
class AssignResponseModel {
  final Response response;
  final List<Maintenance> maintenances;

  AssignResponseModel({
    required this.response,
    required this.maintenances,
  });

  factory AssignResponseModel.fromJson(Map<String, dynamic> json) {
    return AssignResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      maintenances: (json['maintenances'] as List<dynamic>?)
              ?.map(
                  (item) => Maintenance.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
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

// Clase para cada elemento de la lista 'maintenances' (vacía en el ejemplo)
class Maintenance {
  // Define las propiedades de los objetos de mantenimiento aquí.
  // Por ejemplo:
  // final int id;
  // final String description;
  // final DateTime date;

  // Si los datos no están disponibles, puedes usar una clase placeholder
  // o definir los campos según la estructura real que esperas en el futuro.
  Maintenance(/* Define los parámetros aquí */);

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    // Implementa la lógica de mapeo cuando tengas la estructura real del JSON
    return Maintenance(/* Asigna los valores de los parámetros aquí */);
  }
}
