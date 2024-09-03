import '../../either.dart';
import '../../enums.dart';
import '../../models/customer_model.dart';

abstract class NewTicketRepository {
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers();
}
