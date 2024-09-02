import 'dart:convert';
import 'dart:io';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';
import 'ports.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<SignInFailure, String>> createSessionWithLogIn({
    required String username,
    required String password,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final versionPlatform = await mobileVersion();
    final platform = Platform.isIOS ? 'iOS' : 'Android';

    final result = await _http.request(
      '/api/users/v1/mysql/profiles/signin',
      Ports.apiUsersPort,
      method: HttpMethod.post,
      body: {
        "id": 1,
        "username": username,
        "password": password,
        "encryptcode": "dc4514e898db7048305716fa928d61dc",
        "platform": platform,
        "versionplatform": versionPlatform,
        "versionapp": packageInfo.version,
        "token": "",
        "createdat": DateTime.now().toString()
      },
    );

    return result.when(
      (failure) {
        if (failure.statusCode != null) {
          return Either.left(SignInFailure.unauthorized);
        }
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }

        return Either.left(SignInFailure.unknown);
      },
      (responseBody) async {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        final newUserToken = json['profiles'][0]['userToken'] as String;
        final sessionResult = await validateSession(token: newUserToken);
        return sessionResult.when(
          (failure) => Either.left(failure),
          (profile) {
            return Either.right(profile);
          },
        );
      },
    );
  }

  Future<Either<SignInFailure, String>> validateSession(
      {required String token}) async {
    final result = await _http.request(
      '/api/mantiz/v1/mysql/login',
      Ports.mantizPort,
      method: HttpMethod.post,
      body: {"uuid": token},
    );

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
        return Either.right(jsonEncode(json['sessions'][0]));
      },
    );
  }

  Future<String> mobileVersion() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.systemVersion;
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.version.release;
    }
    return '';
  }
}
