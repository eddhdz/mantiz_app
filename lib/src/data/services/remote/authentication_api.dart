import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mantiz/src/domain/either.dart';
import 'package:mantiz/src/domain/enums.dart';

class AuthenticationApi {
  AuthenticationApi(this._client);
  final Client _client;

  Future<Either<SignInFailure, String>> createSessionWithLogIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
            'http://172.168.10.20:17504/api/users/v1/mysql/profiles/signin'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": 1,
          "username": username,
          "password": password,
          "encryptcode": "dc4514e898db7048305716fa928d61dc",
          "platform": "Web Chrome",
          "versionplatform": "1.0",
          "versionapp": "1.0",
          "token": "",
          "createdat": "2024-06-11 12:57"
        }),
      );
      if (response.statusCode == 200) {
        final json = Map<String, dynamic>.from(jsonDecode(response.body));
        final newUserToken = json['profiles'][0]['userToken'] as String;
        return Either.right(newUserToken);
      }
      return Either.left(SignInFailure.unknown);
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }
}
