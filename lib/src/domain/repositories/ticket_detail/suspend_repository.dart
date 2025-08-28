import '../../either.dart';
import '../../enums.dart';

abstract class SuspendRepository {
  Future<Either<GeneralFailure, int>> suspend(
    int fkMaintenance,
    int suspendByPartner,
    String reason,
  );
}
