import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/cancel_repository.dart';
import '../../services/remote/ticket_detail/cancel_service.dart';

class CancelRepositoryImpl implements CancelRepository {
  final CancelService _cancelService;

  CancelRepositoryImpl({required CancelService cancelService})
      : _cancelService = cancelService;

  @override
  Future<Either<GeneralFailure, int>> cancel(
      int fkMaintenance, int cancelByPartner, String reason) {
    return _cancelService.cancelTicket(fkMaintenance, cancelByPartner, reason);
  }
}
