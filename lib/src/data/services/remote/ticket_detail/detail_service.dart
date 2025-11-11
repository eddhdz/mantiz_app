import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../presentation/constants/app_constants.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/ticket_list_response_model.dart';

class DetailService {
  final Http _http;

  DetailService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, TicketListResponseModel>> getDetail(
      int ticketId) async {
    final String currrentDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    try {
      final result = await _http.request(
          '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/maintenances/details',
          method: HttpMethod.post,
          body: {"ticketId": ticketId, "createdat": currrentDate});
      return result.when((failure) => Either.left(GeneralFailure.serverError),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final TicketListResponseModel ticketData =
            TicketListResponseModel.fromJson(parsedBody);

        if (ticketData.response.id == 2) {
          return Either.right(ticketData);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
