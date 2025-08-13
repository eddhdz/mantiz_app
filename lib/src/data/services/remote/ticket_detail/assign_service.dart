import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/assign_response_model.dart';

import 'package:intl/intl.dart';

class AssignService {
  final Http _http;

  AssignService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> assignTicket(
      int fkMaintenance, int asignByPartner, int asignToTechnician) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/asigns/add',
          method: HttpMethod.post,
          body: {
            "id": "0",
            "fkMaintenance": fkMaintenance,
            "asignByPartner": asignByPartner,
            "asignBySupplier": null,
            "asignToTechnician": asignToTechnician,
            "createdAt": currentDate
          });

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignResponseModel assignData =
            AssignResponseModel.fromJson(parsedBody);

        if (assignData.response.id == 1) {
          return Either.right(assignData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
