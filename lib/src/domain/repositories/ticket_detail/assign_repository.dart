import '../../either.dart';
import '../../enums.dart';

abstract class AssignRepository {
  Future<Either<GeneralFailure, int>> assign(
      int fkMaintenance, int asignByPartner, int asignToTechnician);
}
