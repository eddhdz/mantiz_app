class PrizedResponseModel {
  final Response response;
  final List<Costs> maintenances;

  PrizedResponseModel({
    required this.response,
    required this.maintenances,
  });

  factory PrizedResponseModel.fromJson(Map<String, dynamic> json) {
    return PrizedResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      maintenances: (json['maintenances'] as List<dynamic>)
          .map((item) => Costs.fromJson(item as Map<String, dynamic>))
          .toList(),
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

// Clase para cada elemento de la lista 'maintenances'
class Costs {
  final int id;
  final int fkMaintenance;
  final double price; // ✅ Se mapea a double para cálculos
  final DateTime createdAt;
  final int active;

  Costs({
    required this.id,
    required this.fkMaintenance,
    required this.price,
    required this.createdAt,
    required this.active,
  });

  factory Costs.fromJson(Map<String, dynamic> json) {
    return Costs(
      id: json['id'] as int,
      fkMaintenance: json['fkMaintenance'] as int,
      // ✅ Se utiliza double.tryParse para convertir el String a double
      price: double.tryParse(json['price'] as String) ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      active: json['active'] as int,
    );
  }
}
