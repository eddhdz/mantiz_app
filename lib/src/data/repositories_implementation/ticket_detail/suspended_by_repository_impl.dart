import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/suspended_by_repository.dart';
import '../../models/ticket_detail/suspended_by_response_model.dart';
import '../../services/remote/ticket_detail/suspended_by_service.dart';

class SuspendedByRepositoryImpl implements SuspendedByRepository {
  final SuspendedByService _suspendedByService;

  SuspendedByRepositoryImpl({required SuspendedByService suspendedByService})
      : _suspendedByService = suspendedByService;

  @override
  Future<Either<GeneralFailure, SuspendResponseModel>> getSuspensionInfo(
      int fkMaintenance) {
    return _suspendedByService.getSuspensionInfo(fkMaintenance);
  }
}
