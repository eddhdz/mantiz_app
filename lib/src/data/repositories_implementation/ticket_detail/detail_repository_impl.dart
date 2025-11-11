import '../../models/ticket_detail/ticket_list_response_model.dart';
import '../../../domain/repositories/ticket_detail/detail_repository.dart';
import '../../services/remote/ticket_detail/detail_service.dart';
import '../../../domain/either.dart';
import '../../../domain/enums.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailService _detailService;

  DetailRepositoryImpl({required DetailService detailService})
      : _detailService = detailService;

  @override
  Future<Either<GeneralFailure, TicketListResponseModel>> getDetail(
      int ticketId) {
    return _detailService.getDetail(ticketId);
  }
}
