import 'package:mantiz/src/domain/models/branch_office_model.dart';

import '../../either.dart';
import '../../enums.dart';
import '../../models/customer_model.dart';

abstract class NewTicketRepository {
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers();

  Future<Either<GeneralFailure, List<BranchOfficeModel>>> loadBranchs(
      int fkCustomer);
}
