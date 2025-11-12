import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/approve_repository.dart';
import '../../services/remote/ticket_detail/approve_service.dart';

class ApproveRepositoryImpl implements ApproveRepository {
  final ApproveService _approveService;

  ApproveRepositoryImpl({required ApproveService approveService})
      : _approveService = approveService;
  @override
  Future<Either<GeneralFailure, int>> approve(int ticketId, int userId,
      String evidence, String evidencePhoto, String evidencePhoto360) {
    return _approveService.approveTicket(
      ticketId,
      userId,
      evidence,
      evidencePhoto,
      evidencePhoto360,
    );
  }
}
