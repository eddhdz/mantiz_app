import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';

class HomeApi {
  final Http _http;

  HomeApi(this._http);

  Future<Either<GeneralFailure, dynamic>> loadMaintenances(int fkPartnerProfile) async {
    // ignore: unused_local_variable
    var a = 1000;

    final result = await _http.request(
      '/Api_Mantiz/api/mantiz/v1/mysql/tickets',
      method: HttpMethod.post,
      body: {'id': fkPartnerProfile},
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
