import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mantiz/src/data/models/ticket_detail/assign_response_model.dart';
import 'package:mantiz/src/domain/either.dart';
import 'package:mantiz/src/domain/enums.dart';

import '../../../http/http.dart';

class ApproveService {
  final Http _http;

  ApproveService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> approveTicket(
    int fkMaintenance,
    int finishByPartner,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  ) async {
    try {
      final String currrentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/finishes/add',
          method: HttpMethod.post,
          body: {
            "id": 0,
            "fkMaintenance": fkMaintenance,
            "finishByPartner": finishByPartner,
            "fkCBODevice": null,
            "finishByCustomer": null,
            "evidence": evidence,
            "evidencePhoto": evidencePhoto,
            "evidencePhoto360": evidencePhoto360,
            "createdAt": currrentDate
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;
        final AssignResponseModel finishData =
            AssignResponseModel.fromJson(parsedBody);

        if (finishData.response.id == 1) {
          return Either.right(finishData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
