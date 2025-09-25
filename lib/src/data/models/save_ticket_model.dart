class SaveTicketModel {
  final int id;
  final int fkTypeMaintenance;
  final int fkPCL;
  final int fkCBO;
  final int fkStatusMaintenance;
  final int fkCustomerBranchofficeDevice;
  final int folio;
  final String description;
  final String area;
  final String reason;
  final DateTime createdAt;
  int? createdByPartner;
  int? createdByCustomer;
  String? photoevidence;

  SaveTicketModel(
      {required this.id,
      required this.fkTypeMaintenance,
      required this.fkPCL,
      required this.fkCBO,
      required this.fkStatusMaintenance,
      required this.fkCustomerBranchofficeDevice,
      required this.folio,
      required this.description,
      required this.area,
      required this.reason,
      required this.createdAt,
      required this.createdByPartner,
      required this.createdByCustomer,
      required this.photoevidence});

  SaveTicketModel.empty()
      : id = 0,
        fkTypeMaintenance = 0,
        fkPCL = 0,
        fkCBO = 0,
        fkStatusMaintenance = 0,
        fkCustomerBranchofficeDevice = 0,
        folio = 0,
        description = '',
        area = '',
        reason = '',
        createdAt = DateTime.now(),
        createdByPartner = null,
        createdByCustomer = null,
        photoevidence = null;

  factory SaveTicketModel.fromJson(Map<String, dynamic> json) {
    return SaveTicketModel(
        id: int.parse(json['id'].toString()),
        fkTypeMaintenance: int.parse(json['fkTypeMaintenance'].toString()),
        fkPCL: int.parse(json['fkPCL'].toString()),
        fkCBO: int.parse(json['fkCBO'].toString()),
        fkStatusMaintenance: int.parse(json['fkStatusMaintenance'].toString()),
        fkCustomerBranchofficeDevice: int.parse(json['fkCustomerBranchofficeDevice'].toString()),
        folio: int.parse(json['folio'].toString()),
        description: json['description'],
        area: json['area'],
        reason: json['reason'],
        photoevidence: (json['photoevidence'] != null) ? json['photoevidence'] : null,
        createdAt: DateTime.parse(json['createdAt'].toString()),
        createdByPartner: (json['createdByPartner'] != null) ? int.parse(json['createdByPartner'].toString()) : null,
        createdByCustomer: (json['createdByCustomer'] != null) ? int.parse(json['createdByCustomer'].toString()) : null);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fkTypeMaintenance': fkTypeMaintenance,
        'fkPCL': fkPCL,
        'fkCBO': fkCBO,
        'fkStatusMaintenance': fkStatusMaintenance,
        'fkCustomerBranchofficeDevice': fkCustomerBranchofficeDevice,
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
