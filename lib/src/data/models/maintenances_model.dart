import 'models.dart';

import 'package:mantiz/src/data/models/photo_evidence_model.dart';

class MaintenancesModel {
  int id;
  int fkTypeMaintenance;
  int? fkPLC;
  int fkCBO;
  int fkStatusMaintenance;
  int? fkCustomerProfileUpdated;
  String customer;
  int folio;
  dynamic viewFolio;
  String description;
  String? area;
  String reason;
  String status;
  String type;
  DateTime createdAt;
  DateTime? statusUpdateAt;
  BranchOfficeModel branchOfficeModel;
  PhotoEvidenceModel? photoevidence;
  WhoPartnerCreatedModel? whoPartnerCreatedModel;
  WhoCustomerCreatedModel? whoCustomerCreatedModel;
  WhoPartnerUpdatedModel? whoPartnerUpdatedModel;
  WhoCustomerUpdatedModel? whoCustomerUpdatedModel;

  MaintenancesModel(
      {required this.id,
      required this.fkTypeMaintenance,
      required this.fkPLC,
      required this.fkCBO,
      required this.fkStatusMaintenance,
      required this.fkCustomerProfileUpdated,
      required this.customer,
      required this.folio,
      required this.viewFolio,
      required this.description,
      required this.area,
      required this.reason,
      required this.status,
      required this.type,
      required this.createdAt,
      required this.statusUpdateAt,
      required this.branchOfficeModel,
      required this.photoevidence,
      required this.whoPartnerCreatedModel,
      required this.whoCustomerCreatedModel,
      required this.whoPartnerUpdatedModel,
      required this.whoCustomerUpdatedModel});

  factory MaintenancesModel.fromJson(Map<String, dynamic> json) {
    return MaintenancesModel(
        id: int.parse(json['id'].toString()),
        fkTypeMaintenance: int.parse(json['fkTypeMaintenance'].toString()),
        fkPLC: (json['fkPLC'] != null)
            ? int.parse(json['fkPLC'].toString())
            : null,
        fkCBO: int.parse(json['fkCBO'].toString()),
        fkStatusMaintenance: int.parse(json['fkStatusMaintenance'].toString()),
        fkCustomerProfileUpdated:
            int.parse(json['fkCustomerProfileUpdated'].toString()),
        customer: json['customer'],
        folio: int.parse(json['folio'].toString()),
        viewFolio: json['viewFolio'],
        description: json['description'],
        area: json['area'],
        reason: json['reason'],
        status: json['status'],
        type: json['type'],
        createdAt: DateTime.parse(json['createdAt'].toString()),
        statusUpdateAt: (json['statusUpdateAt'] != null)
            ? DateTime.parse(json['statusUpdateAt'].toString())
            : null,
        branchOfficeModel: json['branchOfficeModel'],
        photoevidence:
            (json['photoevidence'] != null) ? json['photoevidence'] : null,
        whoPartnerCreatedModel: (json['whoPartnerCreatedModel'] != null)
            ? json['whoPartnerCreatedModel']
            : null,
        whoCustomerCreatedModel: (json['whoCustomerCreatedModel'] != null)
            ? json['whoCustomerCreatedModel']
            : null,
        whoPartnerUpdatedModel: (json['whoPartnerUpdatedModel'] != null)
            ? json['whoPartnerUpdatedModel']
            : null,
        whoCustomerUpdatedModel: (json['whoCustomerUpdatedModel'] != null)
            ? json['whoCustomerUpdatedModel']
            : null);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fkTypeMaintenance': fkTypeMaintenance,
        'fkPLC': fkPLC,
        'fkCBO': fkCBO,
        'fkStatusMaintenance': fkStatusMaintenance,
        'fkCustomerProfileUpdated': fkCustomerProfileUpdated,
        'customer': customer,
        'folio': folio,
        'viewFolio': viewFolio,
        'description': description,
        'area': area,
        'reason': reason,
        'status': status,
        'type': type,
        'createdAt': createdAt.toIso8601String(),
        'statusUpdateAt':
            (statusUpdateAt != null) ? statusUpdateAt!.toIso8601String() : null,
        'branchOfficeModel': branchOfficeModel,
        'photoevidence': photoevidence,
        'whoPartnerCreatedModel': whoPartnerCreatedModel,
        'whoCustomerCreatedModel': whoCustomerCreatedModel,
        'whoPartnerUpdatedModel': whoPartnerUpdatedModel,
        'whoCustomerUpdatedModel': whoCustomerUpdatedModel
      };
}
