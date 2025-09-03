

import '../../either.dart';
import '../../enums.dart';

abstract class CancelRepository {
  Future<Either<GeneralFailure, int>> cancel(
    int fkMaintenance,
    int cancelByPartner,
    String reason,
  );
}
