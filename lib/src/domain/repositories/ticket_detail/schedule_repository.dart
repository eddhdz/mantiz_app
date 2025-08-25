import '../../either.dart';
import '../../enums.dart';

abstract class ScheduleRepository {
  Future<Either<GeneralFailure, int>> schedule(
    int fkMaintenance,
    int scheduleByPartner,
    int atentionTime,
    String atentionAt,
  );
}
