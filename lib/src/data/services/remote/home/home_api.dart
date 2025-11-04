import 'package:mantiz/src/presentation/constants/app_constants.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';

class HomeApi {
  final Http _http;

  HomeApi(this._http);

  Future<Either<GeneralFailure, dynamic>> loadMaintenances(String? userUuid) async {
    Map<String, dynamic> body;

    if (userUuid == null || userUuid.isEmpty) {
      return Either.left(GeneralFailure.noData);
    }

    var result = await _http.request(
      '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/maintenances',
      method: HttpMethod.post,
      body: {
        'useruuid': userUuid,
        'createdat': DateTime.now().toIso8601String(),
      },
    );

    return result.when((failure) {
      if (failure.statusCode == null) {
        return Either.left(GeneralFailure.noData);
      } else if (failure.exception is NetworkException) {
        return Either.left(GeneralFailure.network);
      } else if (failure.statusCode! >= 400 && failure.statusCode! <= 499) {
        return Either.left(GeneralFailure.clientError);
      } else if (failure.statusCode! >= 500 && failure.statusCode! <= 599) {
        return Either.left(GeneralFailure.serverError);
      } else {
        return Either.left(GeneralFailure.unknown);
      }
    }, (responseBody) {
      return Either.right(responseBody);
    });
  }
}
