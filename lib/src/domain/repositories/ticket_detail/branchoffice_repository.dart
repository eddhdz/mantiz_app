import '../../../data/models/ticket_detail/branchoffice_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class BranchofficeRepository {
  Future<Either<GeneralFailure, BranchofficeResponseModel>> getBranchOffices(
      String fkSupplier);
}
