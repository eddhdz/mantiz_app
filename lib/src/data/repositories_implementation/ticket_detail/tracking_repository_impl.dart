import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/tracking_repository.dart';
import '../../models/ticket_detail/message_response_model.dart';
import '../../services/remote/ticket_detail/tracking_service.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingService _trackingService;

  TrackingRepositoryImpl({required TrackingService trackingService})
      : _trackingService = trackingService;
  @override
  Future<Either<GeneralFailure, MessageResponseModel>> getTrackingMessages(
      int ticketId) {
    return _trackingService.getTrackingMessages(ticketId);
  }
}
