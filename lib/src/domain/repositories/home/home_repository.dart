import '../../either.dart';
import '../../enums.dart';
import '../../../data/models/maintenances_model.dart';

abstract class HomeRepository {
  Future<Either<GeneralFailure, List<MaintenancesModel>>> loadMaintenances();
}
