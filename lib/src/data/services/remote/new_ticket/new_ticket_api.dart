import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../presentation/constants/app_constants.dart';
import '../../../models/models.dart';
import '../../../http/http.dart';
import '../../../models/save_photo_model.dart';

class NewTicketApi {
  final Http _http;

  NewTicketApi(this._http);

  Future<Either<GeneralFailure, dynamic>> savePhoto(SavePhotoModel photo) async {
    final result = await _http.request(
      (photo.type.toLowerCase().contains('image'))
          ? '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/images/add'
          : '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/videos/add',
      method: HttpMethod.post,
      body: {
        'uuidapp': photo.uuidapp,
        'uuid': photo.uuid,
        'name': photo.name,
        'type': photo.type,
        'url': photo.url,
        'im64': photo.im64,
        'createdAt': photo.createdAt.toIso8601String()
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
      '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/maintenances/add',
      method: HttpMethod.post,
      body: {
        'ticketId': ticket.ticketId,
        'fkTypeMaintenance': ticket.fkTypeMaintenance,
        'fkCBO': ticket.fkCBO,
        'fkTypeStatusMaintenance': ticket.fkTypeStatusMaintenance,
        'fkZone': ticket.fkZone,
        'folio': ticket.folio,
        'title': ticket.title,
        'reason': ticket.reason,
        'photo': ticket.photo,
        'createdat': ticket.createdat.toIso8601String(),
        'createdby': ticket.createdby,
        'useruuid': ticket.useruuid,
        'devicefailuresids': ticket.devicefailuresids
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

  Future<Either<GeneralFailure, dynamic>> loadCustomers(String? userUuid) async {
    if (userUuid == null || userUuid.isEmpty) {
      return Either.left(GeneralFailure.noData);
    }

    final result = await _http.request(
      '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/maintenances/enrollstructure',
      method: HttpMethod.post,
      body: {'useruuid': userUuid, 'createdat': DateTime.now().toIso8601String()},
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
