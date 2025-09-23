import 'dart:convert';
import 'dart:io';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../presentation/constants/app_constants.dart';
import '../../../http/http.dart';
import '../../../models/authentication/login_response_model.dart';
import '../../../models/authentication/uuid_session_response_model.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthenticationService {
  final Http _http;

  AuthenticationService(this._http);

  Future<Either<SignInFailure, List<SessionModel>>> createSessionWithLogIn({
    required String username,
    required String password,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final versionPlatform = await mobileVersion();
    final platform = Platform.isIOS ? 'iOS' : 'Android';

    final result = await _http.request(
      ':${AppConstants.usersPort}/api/users/v1/mysql/profiles/signin',
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
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final LoginResponseModel loginData =
            LoginResponseModel.fromJson(parsedBody);

        final newUserToken = loginData.profiles[0].userToken;
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

  Future<Either<SignInFailure, List<SessionModel>>> validateSession(
      {required String token}) async {
    final result = await _http.request(
      ':${AppConstants.apiMantizPort}/api/mantiz/v1/mysql/login',
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
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;
        UuidSessionResponseModel sessionData =
            UuidSessionResponseModel.fromJson(parsedBody);
        return Either.right(sessionData.sessions);
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
