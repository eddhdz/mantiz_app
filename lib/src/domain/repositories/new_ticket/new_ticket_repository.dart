import 'package:mantiz/src/data/models/models.dart';

import '../../either.dart';
import '../../enums.dart';

abstract class NewTicketRepository {
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers();

  Future<Either<GeneralFailure, List<BranchOfficeModel>>> loadBranchs(
      int fkCustomer);

  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel model);
}
