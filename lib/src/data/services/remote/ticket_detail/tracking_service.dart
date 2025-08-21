import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/message_response_model.dart';

class TrackingService {
  final Http _http;

  TrackingService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, MessageResponseModel>> getTrackingMessages(
      int fkMaintenance) async {
    try {
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/tickets/chats',
          method: HttpMethod.post,
          body: {"fkMaintenance": fkMaintenance});
      return result.when((failure) => Either.left(GeneralFailure.empty),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final MessageResponseModel trackingMessageData =
            MessageResponseModel.fromJson(parsedBody);

        if (trackingMessageData.response.id == 2) {
          return Either.right(trackingMessageData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
