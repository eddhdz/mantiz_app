import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:mantiz/src/data/models/authentication/login_response_model.dart';
import 'package:mantiz/src/domain/either.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/presentation/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../http/http.dart';

class SessionService {
  final Http _http;
  final DeviceInfoPlugin _deviceInfoPlugin;

  SessionService(
      {required Http http, required DeviceInfoPlugin deviceInfoPlugin})
      : _http = http,
        _deviceInfoPlugin = deviceInfoPlugin;

  Future<Either<GeneralFailure, LoginResponseModel>> getSession(
    String mobileUuid,
    String firebaseToken,
  ) async {
    try {
      final body = await _buildRequestBody(mobileUuid, firebaseToken);
      final result = await _http.request(
        '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/checksession',
        method: HttpMethod.post,
        body: body,
      );
      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final LoginResponseModel sessionData =
            LoginResponseModel.fromJson(parsedBody);

        if (sessionData.response.id == 2) {
          return Either.right(sessionData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }

  Future<Map<String, dynamic>> _buildRequestBody(
      String mobileUuid, String firebaseToken) async {
    final versionPlatform = await mobileVersion();
    final platform = Platform.isIOS ? 'iOS' : 'Android';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return {
      "username": null,
      "password": null,
      "useruuid": null,
      "mobileuuid": mobileUuid,
      "firebasetoken": firebaseToken,
      "versionapp": packageInfo.version,
      "versionplatform": versionPlatform,
      "platform": platform,
      "visitfrom": "MobileApp",
      "createdat": DateTime.now().toString()
    };
  }

  Future<String> mobileVersion() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.systemVersion;
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.release;
    }
    return '';
  }
}
