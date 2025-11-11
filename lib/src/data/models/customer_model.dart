import 'package:mantiz/src/data/models/branch_office_model.dart';

class CustomerModel {
  String customer;
  List<BranchOfficeModel> branchoffices;

  CustomerModel({required this.customer, required this.branchoffices});

  CustomerModel.onInit()
      : customer = '',
        branchoffices = [];
}
