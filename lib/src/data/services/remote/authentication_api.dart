import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<SignInFailure, String>> createSessionWithLogIn({
    required String username,
    required String password,
  }) async {
    final result = await _http.request('/api/users/v1/mysql/profiles/signin',
        method: HttpMethod.post,
        body: {
          "id": 1,
          "username": username,
          "password": password,
          "encryptcode": "dc4514e898db7048305716fa928d61dc",
          "platform": "Web Chrome",
          "versionplatform": "1.0",
          "versionapp": "1.0",
          "token": "",
          "createdat": "2024-06-11 12:57"
        });

    return result.when(
      (failure) {
        if (failure.statusCode != null) {
          return Either.left(SignInFailure.unknown);
        }
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }

        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        final newUserToken = json['profiles'][0]['userToken'] as String;
        return Either.right(newUserToken);
      },
    );
  }
}
