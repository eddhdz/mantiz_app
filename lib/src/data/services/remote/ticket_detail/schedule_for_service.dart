import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/schedule_for_response_model.dart';

class ScheduleForService {
  final Http _http;

  ScheduleForService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, ScheduledResponseModel>> getScheduled(
      int fkMaintenance) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/tickets/schedules',
        method: HttpMethod.post,
        body: {"fkMaintenance": fkMaintenance},
      );

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final ScheduledResponseModel scheduleForData =
            ScheduledResponseModel.fromJson(parsedBody);

        if (scheduleForData.response.id == 2) {
          return Either.right(scheduleForData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
