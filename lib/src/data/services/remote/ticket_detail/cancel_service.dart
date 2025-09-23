import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/assign_response_model.dart';

class CancelService {
  final Http _http;

  CancelService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> cancelTicket(
    int fkMaintenance,
    int cancelByPartner,
    String reason,
  ) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/cancels/add',
          method: HttpMethod.post,
          body: {
            "id": "0",
            "fkMaintenance": fkMaintenance,
            "cancelByPartner": cancelByPartner,
            "cancelByCustomer": null,
            "cancelBySupplier": null,
            "reason": reason,
            "createdAt": currentDate
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel cancelData =
            AssignResponseModel.fromJson(parsedBody);

        if (cancelData.response.id == 1) {
          return Either.right(cancelData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
