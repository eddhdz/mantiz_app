import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/customer_model.dart';
import '../../../http/http.dart';
import '../ports.dart';

class NewTicketApi {
  final Http _http;

  NewTicketApi(this._http);

  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers(
      int fkPartnerLicence) async {
    final result = await _http.request(
      '/api/mantiz/v1/mysql/partners/licences/customers',
      Ports.mantizPort,
      method: HttpMethod.post,
      body: {'fkPartnerLicence': fkPartnerLicence},
    );

    return result.when((failure) {
      if (failure.statusCode == null) {
        return Either.left(GeneralFailure.noData);
      } else if (failure.exception is NetworkException) {
        return Either.left(GeneralFailure.network);
      } else if (failure.statusCode! >= 400 && failure.statusCode! <= 499) {
        return Either.left(GeneralFailure.clientError);
      } else if (failure.statusCode! >= 500 && failure.statusCode! <= 599) {
        return Either.left(GeneralFailure.serverError);
      } else {
        return Either.left(GeneralFailure.unknown);
      }
    }, (responseBody) {
      List<CustomerModel> customers = [];

      final json = Map<String, dynamic>.from(jsonDecode(responseBody));

      for (var item in json['customers'] as List) {
        //!
        CustomerModel customerModel = CustomerModel(
            id: int.parse(item['id'].toString()),
            fkPartner: int.parse(item['fkPartner'].toString()),
            partner: item['partner'],
            fkCustomer: int.parse(item['fkCustomer'].toString()),
            customer: item['customer']);

        customers.add(customerModel);
      }

      return Either.right(customers);
    });
  }
}
