import '../../../data/models/ticket_detail/message_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class TrackingRepository {
  Future<Either<GeneralFailure, MessageResponseModel>> getTrackingMessages(
      int ticketId);
}
