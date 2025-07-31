import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/user_licence_response_model.dart';

class LicenceService {
  final Http _http;
  LicenceService(this._http);

  Future<Either<GeneralFailure, UserLicenceResponseModel>> getPartnerLicence(
      String fkPartner) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/partners/licences',
        method: HttpMethod.post,
        body: {"fkPartner": fkPartner},
      );
      return result.when(
        (failure) => Either.left(GeneralFailure.unknown),
        (responseBody) {
          Map<String, dynamic> parsedBody;
          if (responseBody is String) {
            parsedBody = jsonDecode(responseBody) as Map<String, dynamic>;
          } else if (responseBody is Map<String, dynamic>) {
            parsedBody = responseBody;
          } else {
            return Either.left(GeneralFailure.unknown);
          }

          final UserLicenceResponseModel licenceData =
              UserLicenceResponseModel.fromJson(parsedBody);
          return Either.right(licenceData);
        },
      );
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
