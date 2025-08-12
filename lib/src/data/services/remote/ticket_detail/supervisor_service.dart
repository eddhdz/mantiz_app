import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/profile_response_model.dart';

class SupervisorService {
  final Http _http;

  SupervisorService({required Http http}) : _http = http;
  Future<Either<GeneralFailure, ProfileResponseModel>> getSupervisors(
      String fkSBO) async {
    try {
      final result = await _http.request(
          '/Api_Mantiz/api/mantiz/v1/mysql/suppliers/branchoffices/profiles',
          method: HttpMethod.post,
          body: {"fkSBO": fkSBO});

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

        final ProfileResponseModel profileData =
            ProfileResponseModel.fromJson(parsedBody);

        return Either.right(profileData);
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
