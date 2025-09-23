import '../../either.dart';
import '../../enums.dart';

abstract class ActivateRepository {
  Future<Either<GeneralFailure, int>> activate(
    int fkMaintenance,
    int openByPartner,
  );
}
