import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/maintenances_model.dart';
import '../../../domain/repositories/home/home_repository.dart';
import '../../services/remote/home/home_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FlutterSecureStorage _storage;

  final HomeApi _homeApi;

  HomeRepositoryImpl(this._homeApi, this._storage);

  @override
  Future<Either<GeneralFailure, List<MaintenancesModel>>>
      loadMaintenances() async {
    final partner = await _storage.read(key: 'fkPartner');

    final homeResult = await _homeApi.loadMaintenances(int.parse(partner!));

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
