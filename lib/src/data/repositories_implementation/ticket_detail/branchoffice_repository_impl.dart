import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/branchoffice_repository.dart';
import '../../models/branchoffice_response_model.dart';
import '../../services/remote/ticket_detail/branch_office_service.dart';

class BranchofficeRepositoryImpl implements BranchofficeRepository {
  final BranchofficeService _branchofficeService;

  BranchofficeRepositoryImpl({required BranchofficeService branchofficeService})
      : _branchofficeService = branchofficeService;

  @override
  Future<Either<GeneralFailure, BranchofficeResponseModel>> getBranchOffices(
      String fkSupplier) {
    return _branchofficeService.getBranchoffices(fkSupplier);
  }
}
