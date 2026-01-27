import 'dart:convert';

import 'package:mantiz/src/data/http/http.dart';
import 'package:mantiz/src/data/models/image/image_model.dart';
import 'package:mantiz/src/domain/either.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/presentation/constants/app_constants.dart';

class ImagesService {
  final Http _http;
  ImagesService({required Http http}) : _http = http;

  Future<Either<GeneralFailure, String>> getImage(
      String? uuid, String? uuidapp, String? name, String? type) async {
    try {
      final result = await _http.request(
        '${AppConstants.symbol}${AppConstants.usersPortTest}/mobile/v1/images',
        method: HttpMethod.post,
        body: {
          "uuid": uuid,
          "uuidapp": uuidapp,
          "name": name,
          "type": type,
          "url": ""
        },
      );

      return result.when((failure) => Either.left(GeneralFailure.unknown),
          (responseBody) {
        final Map<String, dynamic> parsedBody = (responseBody is String)
            ? jsonDecode(responseBody) as Map<String, dynamic>
            : responseBody as Map<String, dynamic>;

        final ImageResponseModel imageData =
            ImageResponseModel.fromJson(parsedBody);

        if (imageData.response.id == 2) {
          return Either.right(imageData.list[0].fileBase64);
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      });
    } catch (e) {
      return Either.left(GeneralFailure.unknown);
    }
  }

  Future<Map<String, dynamic>> _buildRequestBody(
      String uuid, String uuidapp, String name, String type) async {
    return {
      "uuid": uuid,
      "uuidapp": uuidapp,
      "name": name,
      "type": type,
      "url": ""
    };
  }
}
