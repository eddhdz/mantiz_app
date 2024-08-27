import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/maintenances_model.dart';
import '../../../domain/repositories/home/home_repository.dart';
import '../../services/remote/home/home_api.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApi _homeApi;

  HomeRepositoryImpl(this._homeApi);

  @override
  Future<Either<GeneralFailure, List<MaintenancesModel>>>
      loadMaintenances() async {
    final homeResult = await _homeApi.loadMaintenances();

    return homeResult.when(
      (failure) {
        return Either.left(failure);
      },
      (maintenances) {
        return Either.right(maintenances);
      },
    );
  }
}
