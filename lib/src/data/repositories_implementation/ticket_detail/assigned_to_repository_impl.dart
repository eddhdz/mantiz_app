import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/assigned_to_repository.dart';
import '../../models/ticket_detail/assigned_to_response_model.dart';
import '../../services/remote/ticket_detail/assigned_to_service.dart';

class AssignedToRepositoryImpl implements AssignedToRepository {
  final AssignedToService _assignedToService;

  AssignedToRepositoryImpl({required AssignedToService assignedToService})
      : _assignedToService = assignedToService;

  @override
  Future<Either<GeneralFailure, AssignedToResponseModel>> getAssigned(
      String fkMaintenance) {
    return _assignedToService.getAssigned(fkMaintenance);
  }
}
