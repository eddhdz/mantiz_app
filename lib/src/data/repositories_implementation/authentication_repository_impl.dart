import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/authentication_repository.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;

  AuthenticationRepositoryImpl(
    this._secureStorage,
  );

  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String userName,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 3));

    if (userName != 'test') {
      return Either.left(SignInFailure.notFound);
    }
    if (password != '1234567') {
      return Either.left(SignInFailure.unauthorized);
    }

    await _secureStorage.write(key: _key, value: '1');

    return Either.right(User());
  }
}
