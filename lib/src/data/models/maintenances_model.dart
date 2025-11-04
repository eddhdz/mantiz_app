import 'models.dart';

class MaintenancesModel {
  int id;
  String customer;
  List<BranchOfficeModel> branchoffices;

  MaintenancesModel({
    required this.id,
    required this.customer,
    required this.branchoffices,
  });

  MaintenancesModel.init()
      : id = 0,
        customer = '',
        branchoffices = [];

  // factory MaintenancesModel.fromJson(Map<String, dynamic> json) {
  //   return MaintenancesModel(
  //     id: int.parse(json['id'].toString()),
  //     customer: json['customer'],
  //     branchoffices: BranchOfficeModel.fromJson(json['branchoffices']),
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'customer': customer,
  //       'branchoffices': branchoffices.toJson(),
  //     };
}
