import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/prized_by_response_model.dart';

class PrizedByService {
  final Http _http;

  PrizedByService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, PrizedResponseModel>> getPrices(
      int fkMaintenance) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/tickets/prices',
        method: HttpMethod.post,
        body: {"fkMaintenance": fkMaintenance},
      );

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final PrizedResponseModel pricesData =
            PrizedResponseModel.fromJson(parsedBody);

        if (pricesData.response.id == 2) {
          return Either.right(pricesData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
