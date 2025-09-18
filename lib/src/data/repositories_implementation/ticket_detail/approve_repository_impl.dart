import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/approve_repository.dart';
import '../../services/remote/ticket_detail/approve_service.dart';

class ApproveRepositoryImpl implements ApproveRepository {
  final ApproveService _approveService;

  ApproveRepositoryImpl({required ApproveService approveService})
      : _approveService = approveService;
  @override
  Future<Either<GeneralFailure, int>> approve(
      int fkMaintenance,
      int finishByPartner,
      String evidence,
      String evidencePhoto,
      String evidencePhoto360) {
    return _approveService.approveTicket(
      fkMaintenance,
      finishByPartner,
      evidence,
      evidencePhoto,
      evidencePhoto360,
    );
  }
}
