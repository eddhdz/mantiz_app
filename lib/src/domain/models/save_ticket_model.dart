class SaveTicketModel {
  final int id;
  final int fkTypeMaintenance;
  final int fkPCL;
  final int fkCBO;
  final int fkStatusMaintenance;
  final int folio;
  final String description;
  final String area;
  final String reason;
  final String? photoevidence;
  final DateTime createdAt;
  final int? createdByPartner;
  final int? createdByCustomer;

  SaveTicketModel(
      {required this.id,
      required this.fkTypeMaintenance,
      required this.fkPCL,
      required this.fkCBO,
      required this.fkStatusMaintenance,
      required this.folio,
      required this.description,
      required this.area,
      required this.reason,
      required this.photoevidence,
      required this.createdAt,
      required this.createdByPartner,
      required this.createdByCustomer});

  factory SaveTicketModel.fromJson(Map<String, dynamic> json) {
    return SaveTicketModel(
        id: int.parse(json['id'].toString()),
        fkTypeMaintenance: int.parse(json['fkTypeMaintenance'].toString()),
        fkPCL: int.parse(json['fkPCL'].toString()),
        fkCBO: int.parse(json['fkCBO'].toString()),
        fkStatusMaintenance: int.parse(json['fkStatusMaintenance'].toString()),
        folio: int.parse(json['folio'].toString()),
        description: json['description'],
        area: json['area'],
        reason: json['reason'],
        photoevidence:
            (json['photoevidence'] != null) ? json['photoevidence'] : null,
        createdAt: DateTime.parse(json['createdAt'].toString()),
        createdByPartner: (json['createdByPartner'] != null)
            ? int.parse(json['createdByPartner'].toString())
            : null,
        createdByCustomer: (json['createdByCustomer'] != null)
            ? int.parse(json['createdByCustomer'].toString())
            : null);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fkTypeMaintenance': fkTypeMaintenance,
        'fkPCL': fkPCL,
        'fkCBO': fkCBO,
        'fkStatusMaintenance': fkStatusMaintenance,
        'folio': folio,
        'description': description,
        'area': area,
        'reason': reason,
        'photoevidence': photoevidence,
        'createdAt': createdAt.toIso8601String(),
        'createdByPartner': createdByPartner,
        'createdByCustomer': createdByCustomer
      };
}
