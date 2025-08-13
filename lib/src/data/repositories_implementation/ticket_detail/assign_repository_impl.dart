import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/assign_repository.dart';
import '../../services/remote/ticket_detail/assign_service.dart';

class AssignRepositoryImpl implements AssignRepository {
  final AssignService _assignService;

  AssignRepositoryImpl({required AssignService assignService})
      : _assignService = assignService;
  @override
  Future<Either<GeneralFailure, int>> assign(
      int fkMaintenance, int asignByPartner, int asignToTechnician) {
    return _assignService.assignTicket(
        fkMaintenance, asignByPartner, asignToTechnician);
  }
}
