import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/message_response_model.dart';

class AddMessageService {
  final Http _http;

  AddMessageService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, int>> addMessage(
    int fkMaintenance,
    int fkProfile,
    String message,
  ) async {
    try {
      final String currentDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/chats/add',
          method: HttpMethod.post,
          body: {
            "id": 0,
            "fkMaintenance": fkMaintenance,
            "fkProfile": fkProfile,
            "body": message,
            "createdAt": currentDate
          });
      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final MessageResponseModel addMessageData =
            MessageResponseModel.fromJson(parsedBody);

        if (addMessageData.response.id == 1) {
          return Either.right(addMessageData.response.id);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
