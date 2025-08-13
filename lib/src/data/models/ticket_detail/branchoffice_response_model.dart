import 'dart:convert';

// Modelo principal que mapea la respuesta completa de la API
class BranchofficeResponseModel {
  final Response response;
  final List<BranchofficeData> branchoffices;

  BranchofficeResponseModel({
    required this.response,
    required this.branchoffices,
  });

  factory BranchofficeResponseModel.fromJson(Map<String, dynamic> json) {
    return BranchofficeResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      branchoffices: (json['branchoffices'] as List<dynamic>)
          .map((item) => BranchofficeData.fromJson(item as Map<String, dynamic>))
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

// Clase para cada elemento de la lista 'branchoffices'
class BranchofficeData {
  final int id;
  final int fkSupplier;
  final int fkBranchoffice;
  final String uuidBO;
  final BranchOffice branchoffice; // El objeto anidado
  final String supplier;

  BranchofficeData({
    required this.id,
    required this.fkSupplier,
    required this.fkBranchoffice,
    required this.uuidBO,
    required this.branchoffice,
    required this.supplier,
  });

  factory BranchofficeData.fromJson(Map<String, dynamic> json) {
    // Primero, decodificamos el JSON anidado que está en el campo 'branchoffice'
    final Map<String, dynamic> branchOfficeJson =
        jsonDecode(json['branchoffice'] as String) as Map<String, dynamic>;

    return BranchofficeData(
      id: json['id'] as int,
      fkSupplier: json['fkSupplier'] as int,
      fkBranchoffice: json['fkBranchoffice'] as int,
      uuidBO: json['uuidBO'] as String,
      // Usamos el JSON decodificado para crear la instancia de BranchOffice
      branchoffice: BranchOffice.fromJson(branchOfficeJson), 
      supplier: json['supplier'] as String,
    );
  }
}

// Clase para el JSON de la sucursal (el contenido del campo anidado)
class BranchOffice {
  final int id;
  final int fkSubcompany;
  final String description;
  final String location;
  final String latitud;
  final String longitud;
  final String? imagen;
  final String clave;
  final String subcompany;
  final String uuidBO;

  BranchOffice({
    required this.id,
    required this.fkSubcompany,
    required this.description,
    required this.location,
    required this.latitud,
    required this.longitud,
    required this.imagen,
    required this.clave,
    required this.subcompany,
    required this.uuidBO,
  });

  factory BranchOffice.fromJson(Map<String, dynamic> json) {
    return BranchOffice(
      id: json['id'] as int,
      fkSubcompany: json['fkSubcompany'] as int,
      description: json['description'] as String,
      location: json['location'] as String,
      latitud: json['latitud'] as String,
      longitud: json['longitud'] as String,
      imagen: json['imagen'] as String?,
      clave: json['clave'] as String,
      subcompany: json['subcompany'] as String,
      uuidBO: json['uuidBO'] as String,
    );
  }
}