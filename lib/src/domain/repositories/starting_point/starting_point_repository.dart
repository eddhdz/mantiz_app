import '../../../data/models/maintenances_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class StartingPointRepository {
  Future<Either<GeneralFailure, List<MaintenancesModel>>> loadMaintenances();
}
