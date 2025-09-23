// ignore: unused_import
import 'dart:convert';

class SupplierResponseModel {
  final Response response;
  final List<Supplier> suppliers;

  SupplierResponseModel({
    required this.response,
    required this.suppliers,
  });

  factory SupplierResponseModel.fromJson(Map<String, dynamic> json) {
    return SupplierResponseModel(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      suppliers: (json['suppliers'] as List<dynamic>)
          .map((item) => Supplier.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

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

class Supplier {
  final int id;
  final int fkPartner;
  final String partner;
  final int fkSupplier;
  final String supplier;

  Supplier({
    required this.id,
    required this.fkPartner,
    required this.partner,
    required this.fkSupplier,
    required this.supplier,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] as int,
      fkPartner: json['fkPartner'] as int,
      partner: json['partner'] as String,
      fkSupplier: json['fkSupplier'] as int,
      supplier: json['supplier'] as String,
    );
  }
}