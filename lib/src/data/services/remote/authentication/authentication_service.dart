import 'dart:convert';
import 'dart:io';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../presentation/constants/app_constants.dart';
import '../../../http/http.dart';
import '../../../models/authentication/login_response_model.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthenticationService {
  final Http _http;

  AuthenticationService(this._http);

  Future<Either<SignInFailure, LoginResponseModel>> createSessionWithLogIn({
    required String username,
    required String password,
    required String mobileUuid,
    required String? firebasetoken,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final versionPlatform = await mobileVersion();
    final platform = Platform.isIOS ? 'iOS' : 'Android';

    final result = await _http.request(
      '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/signin',
      method: HttpMethod.post,
      body: {
        "username": username,
        "password": password,
        "useruuid": null,
        "mobileuuid": mobileUuid,
        "firebasetoken": firebasetoken,
        "versionapp": packageInfo.version,
        "versionplatform": versionPlatform,
        "platform": platform,
        "visitfrom": "MobileApp",
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
        if (loginData.response.id > 0) {
          return Either.right(loginData);
        } else {
          return Either.left(SignInFailure.unknown);
        }
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
