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
}
