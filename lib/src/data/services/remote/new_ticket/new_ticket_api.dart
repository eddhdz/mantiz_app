import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../models/models.dart';
import '../../../http/http.dart';
import '../../../models/save_photo_model.dart';

class NewTicketApi {
  final Http _http;

  NewTicketApi(this._http);

  Future<Either<GeneralFailure, dynamic>> savePhoto(SavePhotoModel photo) async {
    final result = await _http.request(
      '/Api_Images/images/add',
      method: HttpMethod.post,
      body: {
        'uuidapp': photo.uuidapp,
        'uuid': photo.uuid,
        'name': photo.name,
        'type': photo.type,
        'url': photo.url,
        'im64': photo.im64,
        'createdAt': photo.createdAt.toIso8601String(),
      },
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
      return Either.right(responseBody);
    });
  }

  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel ticket) async {
    final result = await _http.request(
      '/Api_Mantiz/api/mantiz/v1/mysql/tickets/add',
      method: HttpMethod.post,
      body: {
        'id': ticket.id,
        'fkTypeMaintenance': ticket.fkTypeMaintenance,
        'fkPLC': ticket.fkPCL,
        'fkCBO': ticket.fkCBO,
        'fkStatusMaintenance': ticket.fkStatusMaintenance,
        'folio': ticket.folio,
        'description': ticket.description,
        'area': ticket.area,
        'reason': ticket.reason,
        'photoevidence': ticket.photoevidence,
        'createdAt': ticket.createdAt.toIso8601String(),
        'createdByPartner': ticket.createdByPartner,
        'createdByCustomer': ticket.createdByCustomer
      },
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
      return Either.right(true);
    });
  }

  Future<Either<GeneralFailure, dynamic>> loadBranchs(int fkCustomer) async {
    final result = await _http.request(
      '/Api_Mantiz/api/mantiz/v1/mysql/customers/branchoffices',
      method: HttpMethod.post,
      body: {'fkCustomer': fkCustomer},
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
      return Either.right(responseBody);
    });
  }

  Future<Either<GeneralFailure, dynamic>> loadCustomers(int fkPartnerLicence) async {
    final result = await _http.request(
      '/Api_Mantiz/api/mantiz/v1/mysql/partners/licences/customers',
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
      return Either.right(responseBody);
    });
  }
}
