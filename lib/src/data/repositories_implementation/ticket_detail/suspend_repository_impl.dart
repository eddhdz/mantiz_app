import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/suspend_repository.dart';
import '../../services/remote/ticket_detail/suspend_service.dart';

class SuspendRepositoryImpl implements SuspendRepository {
  final SuspendService _suspendService;

  SuspendRepositoryImpl({required SuspendService suspendService})
      : _suspendService = suspendService;
  @override
  Future<Either<GeneralFailure, int>> suspend(
      int fkMaintenance, int suspendByPartner, String reason) {
    return _suspendService.suspendTicket(
        fkMaintenance, suspendByPartner, reason);
  }
}
