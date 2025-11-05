import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/session/logout_repository.dart';
import '../../services/remote/session/logout_service.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutService _logoutService;
  final FlutterSecureStorage _secureStorage;

  LogoutRepositoryImpl(
      {required LogoutService logoutService,
      required FlutterSecureStorage secureStorage})
      : _logoutService = logoutService,
        _secureStorage = secureStorage;

  @override
  Future<Either<GeneralFailure, int>> logout() async {
    final mobileUuid = await _secureStorage.read(key: 'mobileuuid');
    if (mobileUuid == null) {
      return Either.left(GeneralFailure.noData);
    }

    final result = await _logoutService.logOut(mobileUuid);

    return result.when((failure) => Either.left(failure), (success) async {
      await _secureStorage.delete(key: 'mobileuuid');
      await _secureStorage.delete(key: 'firebasetoken');
      await _secureStorage.delete(key: 'uuid');
      await _secureStorage.delete(key: 'useruuid');
      await _secureStorage.delete(key: 'typeuser');
      await _secureStorage.delete(key: 'typerol');

      return Either.right(success);
    });
  }
}
