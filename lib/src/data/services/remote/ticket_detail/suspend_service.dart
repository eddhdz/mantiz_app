import 'dart:convert';
import 'package:intl/intl.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/assign_response_model.dart';

class SuspendService {
  final Http _http;

  SuspendService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> suspendTicket(
    int fkMaintenance,
    int suspendByPartner,
    String reason,
  ) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/suspends/add',
          method: HttpMethod.post,
          body: {
            "id": "0",
            "fkMaintenance": fkMaintenance,
            "suspendbyPartner": suspendByPartner,
            "suspendbyCustomer": null,
            "suspendbySupplier": null,
            "reason": reason,
            "createdAt": currentDate
          });
      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel suspendData =
            AssignResponseModel.fromJson(parsedBody);
        if (suspendData.response.id == 1) {
          return Either.right(suspendData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
