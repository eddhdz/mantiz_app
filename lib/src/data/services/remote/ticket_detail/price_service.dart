import 'dart:convert';
import 'package:intl/intl.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/assign_response_model.dart';

class PriceService {
  final Http _http;

  PriceService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> priceTicket(
    int fkMaintenance,
    int createdByPartner,
    double price,
  ) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/prices/add',
          method: HttpMethod.post,
          body: {
            "id": 0,
            "fkMaintenance": fkMaintenance,
            "price": price,
            "createdAt": currentDate,
            "createdByPartner": createdByPartner,
            "createdBySupplier": null
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel priceData =
            AssignResponseModel.fromJson(parsedBody);

        if (priceData.response.id == 1) {
          return Either.right(priceData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
