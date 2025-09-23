import 'dart:convert';

import 'package:mantiz/src/data/models/ticket_detail/assigned_to_response_model.dart';
import 'package:mantiz/src/domain/either.dart';
import 'package:mantiz/src/domain/enums.dart';

import '../../../http/http.dart';

class AssignedToService {
  final Http _http;

  AssignedToService({required Http http}) : _http = http;
  Future<Either<GeneralFailure, AssignedToResponseModel>> getAssigned(
      String fkMaintenance) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/tickets/asigns',
        method: HttpMethod.post,
        body: {"fkMaintenance": fkMaintenance},
      );
      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final AssignedToResponseModel assignedToData =
            AssignedToResponseModel.fromJson(parsedBody);
        if (assignedToData.response.id > 0) {
          return Either.right(assignedToData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
