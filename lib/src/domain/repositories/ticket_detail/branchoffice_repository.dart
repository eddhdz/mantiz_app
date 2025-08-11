import '../../../data/models/branchoffice_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class BranchofficeRepository {
  Future<Either<GeneralFailure, BranchofficeResponseModel>> getBranchOffices(
      String fkSupplier);
}
