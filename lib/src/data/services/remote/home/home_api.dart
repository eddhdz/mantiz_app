import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';

class HomeApi {
  final Http _http;

  HomeApi(this._http);

  Future<Either<GeneralFailure, dynamic>> loadMaintenances(
      int fkPartnerProfile, String role) async {
    // ignore: unused_local_variable
    var a = 1000;
    String path;
    Map<String, dynamic> body;

    switch (role) {
      case 'partner':
        path = '/Api_Mantiz/api/mantiz/v1/mysql/tickets';
        body = {'id': fkPartnerProfile};
        break;
      case 'customer':
        path = '/Api_Mantiz/api/mantiz/v1/mysql/tickets/customers';
        body = {'id': fkPartnerProfile};
        break;
      case 'supplier':
        path = '/Api_Mantiz/api/mantiz/v1/mysql/tickets/suppliers';
        body = {
          'id': 0,
          'fkProfile': fkPartnerProfile,
        };
        break;
      default:
        return Either.left(GeneralFailure.noData);
    }

    var result = await _http.request(
      path,
      method: HttpMethod.post,
      body: body,
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
