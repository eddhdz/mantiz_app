import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mantiz/src/presentation/constants/app_constants.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/assign_response_model.dart';

class DoneService {
  final Http _http;

  DoneService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> doneTicket(
    int ticketId,
    int userId,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  ) async {
    try {
      final String currrentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      final result = await _http.request(
          '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/maintenances/finishes/add',
          method: HttpMethod.post,
          body: {
            "finishId": 0,
            "ticketId": ticketId,
            "reason": evidence,
            "photo": evidencePhoto,
            "photo360": evidencePhoto360,
            "createdby": userId,
            "createdat": currrentDate
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel doneData =
            AssignResponseModel.fromJson(parsedBody);

        if (doneData.response.id == 2) {
          return Either.right(doneData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
