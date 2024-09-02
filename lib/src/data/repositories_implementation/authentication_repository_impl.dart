import 'dart:convert';

import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/remote/authentication_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationApi _authenticationApi;

  AuthenticationRepositoryImpl(
    this._secureStorage,
    this._authenticationApi,
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
  Future<Either<SignInFailure, String>> signIn(
    String userName,
    String password,
  ) async {
    final loginResult = await _authenticationApi.createSessionWithLogIn(
      username: userName,
      password: password,
    );
    return loginResult.when(
      (failure) {
        return Either.left(failure);
      },
      (profileUser) {
        _secureStorage.write(
          key: 'fkPartner',
          value: jsonDecode(profileUser)['fkPartner'].toString(),
        );
        _secureStorage.write(
          key: 'fkPartnerLicence',
          value: jsonDecode(profileUser)['fkPartnerLicence'].toString(),
        );
        return Either.right(profileUser);
      },
    );
  }
}
