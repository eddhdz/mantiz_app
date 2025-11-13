import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/done_repositroy.dart';
import '../../services/remote/ticket_detail/done_service.dart';

class DoneRepositoryImpl implements DoneRepositroy {
  final DoneService _doneService;

  DoneRepositoryImpl({required DoneService doneService})
      : _doneService = doneService;
  @override
  Future<Either<GeneralFailure, int>> done(int ticketId, int userId,
      String evidence, String evidencePhoto, String evidencePhoto360) {
    return _doneService.doneTicket(ticketId, userId, evidence,
        evidencePhoto, evidencePhoto360);
  }
}
