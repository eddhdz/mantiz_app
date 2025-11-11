import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../presentation/constants/app_constants.dart';
import '../../../http/http.dart';
import '../../../models/authentication/login_response_model.dart';

class LogoutService {
  final Http _http;

  LogoutService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> logOut(String mobileUuid) async {
    try {
      final body = await _buildRequestBody(mobileUuid);
      final result = await _http.request(
        '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/signout',
        method: HttpMethod.post,
        body: body,
      );

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final LoginResponseModel logOutData =
            LoginResponseModel.fromJson(parsedBody);

        if (logOutData.response.id == 1) {
          return Either.right(logOutData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }

  Future<Map<String, dynamic>> _buildRequestBody(String mobileUuid) async {
    return {
      "username": null,
      "password": null,
      "useruuid": null,
      "mobileuuid": mobileUuid,
      "firebasetoken": null,
      "versionapp": null,
      "versionplatform": null,
      "platform": null,
      "visitfrom": null,
      "createdat": null
    };
  }
}
