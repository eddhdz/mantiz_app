import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mantiz/src/data/models/ticket_detail/assign_response_model.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';

class ScheduleService {
  final Http _http;

  ScheduleService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> scheduleTicket(
    int fkMaintenance,
    int scheduleByPartner,
    int atentionTime,
    String atentionAt,
  ) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/schedules/add',
          method: HttpMethod.post,
          body: {
            "id": 0,
            "fkMaintenance": fkMaintenance,
            "scheduleByPartner": scheduleByPartner,
            "atentionTime": atentionTime,
            "atentionAt": atentionAt,
            "createdAt": currentDate
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel scheduleData =
            AssignResponseModel.fromJson(parsedBody);

        if (scheduleData.response.id == 1) {
          return Either.right(scheduleData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
