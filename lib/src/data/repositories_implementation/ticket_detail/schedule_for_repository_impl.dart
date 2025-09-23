import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/schedule_for_repository.dart';
import '../../models/ticket_detail/schedule_for_response_model.dart';
import '../../services/remote/ticket_detail/schedule_for_service.dart';

class ScheduleForRepositoryImpl implements ScheduleForRepository {
  final ScheduleForService _scheduleForService;

  ScheduleForRepositoryImpl({required ScheduleForService scheduleForService})
      : _scheduleForService = scheduleForService;
  @override
  Future<Either<GeneralFailure, ScheduledResponseModel>> getScheduled(
      int fkMaintenance) {
    return _scheduleForService.getScheduled(fkMaintenance);
  }
}
