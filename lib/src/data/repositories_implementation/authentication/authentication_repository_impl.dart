import 'package:mantiz/src/data/models/authentication/login_response_model.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../models/user_model.dart';
import '../../../domain/repositories/authentication/authentication_repository.dart';
import '../../services/remote/authentication/authentication_service.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationService _authenticationApi;

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
  Future<Either<SignInFailure, LoginResponseModel>> signIn(
    String userName,
    String password,
    String mobileUuid,
    String? firebasetoken,
    
  ) async {
    final loginResult = await _authenticationApi.createSessionWithLogIn(
      username: userName,
      password: password,
      mobileUuid: mobileUuid,
      firebasetoken: firebasetoken,
      
    );
    return loginResult.when(
      (failure) {
        return Either.left(failure);
      },
      (profileUser) {
        _secureStorage.write(
          key: 'uuid',
          value: profileUser.list[0].profile.mobile.uuid,
        );
        _secureStorage.write(
          key: 'useruuid',
          value: profileUser.list[0].profile.user.useruuid,
        );
        return Either.right(profileUser);
      },
    );
  }
}
