import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/supervisor_repository.dart';
import '../../models/ticket_detail/profile_response_model.dart';
import '../../services/remote/ticket_detail/supervisor_service.dart';

class SupervisorRepositoryImpl implements SupervisorRepository {
  final SupervisorService _supervisorService;

  SupervisorRepositoryImpl({required SupervisorService supervisorService})
      : _supervisorService = supervisorService;
  @override
  Future<Either<GeneralFailure, ProfileResponseModel>> getSupervisors(
      String fkSBO) {
    return _supervisorService.getSupervisors(fkSBO);
  }
}
