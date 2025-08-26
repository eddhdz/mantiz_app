import '../../../data/models/ticket_detail/schedule_for_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class ScheduleForRepository {
  Future<Either<GeneralFailure, ScheduledResponseModel>> getScheduled(
      int fkMaintenance);
}
