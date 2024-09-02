import '../../either.dart';
import '../../enums.dart';
import '../../models/maintenances_model.dart';

abstract class HomeRepository {
  Future<Either<GeneralFailure, List<MaintenancesModel>>> loadMaintenances();
}
