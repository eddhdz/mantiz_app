import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../models/authentication/uuid_session_response_model.dart';
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
  Future<Either<SignInFailure, List<SessionModel>>> signIn(
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
        if (profileUser[0].customer != null) {
          _secureStorage.write(
            key: 'Customer',
            value: profileUser[0].customer!.fkCustomerProfile.toString(),
          );
        }

        if (profileUser[0].supplier != null) {
          _secureStorage.write(
            key: 'Supplier',
            value: profileUser[0].supplier!.fkSupplierProfile.toString(),
          );
        }

        if (profileUser[0].partner.fkPartnerProfile != null) {
          _secureStorage.write(
            key: 'Partner',
            value: profileUser[0].partner.fkPartnerProfile.toString(),
          );
        }

        _secureStorage.write(
          key: 'fkPartner',
          value: profileUser[0].partner.fkPartner.toString(),
        );
        _secureStorage.write(
          key: 'fkPartnerLicence',
          value: profileUser[0].partner.fkPartnerLicence.toString(),
        );
        return Either.right(profileUser);
      },
    );
  }
}
