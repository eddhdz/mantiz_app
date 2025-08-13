import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../http/http.dart';
import '../../../models/ticket_detail/supplier_response_model.dart';

class SuppliersService {
  final Http _http;

  SuppliersService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, SupplierResponseModel>> getSuppliers(
      String fkPartnerLicence) async {
    try {
      final result = await _http.request(
        '/Api_Mantiz/api/mantiz/v1/mysql/partners/licences/suppliers',
        method: HttpMethod.post,
        body: {"fkPartnerLicence": fkPartnerLicence},
      );
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

        final SupplierResponseModel supplierData =
            SupplierResponseModel.fromJson(parsedBody);
        return Either.right(supplierData);
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }
}
