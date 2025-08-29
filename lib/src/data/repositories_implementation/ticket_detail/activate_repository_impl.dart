import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/activate_repository.dart';
import '../../services/remote/ticket_detail/activate_service.dart';

class ActivateRepositoryImpl implements ActivateRepository {
  final ActivateService _activateService;

  ActivateRepositoryImpl({required ActivateService activateService})
      : _activateService = activateService;
  @override
  Future<Either<GeneralFailure, int>> activate(
      int fkMaintenance, int openByPartner) {
    return _activateService.activateTicket(fkMaintenance, openByPartner);
  }
}
