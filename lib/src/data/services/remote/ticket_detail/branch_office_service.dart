import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/branchoffice_response_model.dart';

class BranchofficeService {
  final Http _http;

  BranchofficeService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, BranchofficeResponseModel>> getBranchoffices(
      String fkSupplier) async {
    try {
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/suppliers/branchoffices',
          method: HttpMethod.post,
          body: {"fkSupplier": fkSupplier});

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        Map<String, dynamic> parsedBody;
        if (responseBody is String) {
          parsedBody = jsonDecode(responseBody) as Map<String, dynamic>;
        } else if (responseBody is Map<String, dynamic>) {
          parsedBody = responseBody;
        } else {
          return Either.left(GeneralFailure.unknown);
        }

        final BranchofficeResponseModel branchofficeData =
            BranchofficeResponseModel.fromJson(parsedBody);
        return Either.right(branchofficeData);
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
