import '../../../data/models/ticket_detail/ticket_list_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class DetailRepository {
  Future<Either<GeneralFailure, TicketListResponseModel>> getDetail(
      int ticketId);
}
