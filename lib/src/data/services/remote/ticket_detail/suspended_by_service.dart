import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/suspended_by_response_model.dart';

class SuspendedByService {
  final Http _http;

  SuspendedByService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, SuspendResponseModel>> getSuspensionInfo(
      int fkMaintenance) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/tickets/suspends',
        method: HttpMethod.post,
        body: {"fkMaintenance": fkMaintenance},
      );

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final SuspendResponseModel suspensionData =
            SuspendResponseModel.fromJson(parsedBody);

        if (suspensionData.response.id == 2) {
          return Either.right(suspensionData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
