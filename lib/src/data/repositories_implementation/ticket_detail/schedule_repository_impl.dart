import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/schedule_repository.dart';
import '../../services/remote/ticket_detail/schedule_service.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleService _scheduleService;

  ScheduleRepositoryImpl({required ScheduleService scheduleService})
      : _scheduleService = scheduleService;
  @override
  Future<Either<GeneralFailure, int>> schedule(int fkMaintenance,
      int scheduleByPartner, int atentionTime, String atentionAt) {
    return _scheduleService.scheduleTicket(
        fkMaintenance, scheduleByPartner, atentionTime, atentionAt);
  }
}
