import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import '../../domain/either.dart';
import '../../domain/enums.dart';

import 'package:http/http.dart';

part 'failure.dart';
part 'parse_response_body.dart';

class Http {
  final String _baseUrl;
  final Client _client;

  Http(this._client, this._baseUrl);

  Future<Either<HttpFailure, dynamic>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
    try {
      Uri url = Uri.parse('$_baseUrl$path');
      headers = {
        "Content-Type": "application/json",
        ...headers,
      };
      late final Response response;
      final bodyString = jsonEncode(body);

      logs = {
        'url': url.toString(),
        'method': method.name,
        'body': body,
      };
      switch (method) {
        case HttpMethod.get:
          response = await _client
              .get(
                url,
                headers: headers,
              )
              .timeout(const Duration(seconds: 120));
          break;
        case HttpMethod.post:
          response = await _client
              .post(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(const Duration(seconds: 120));

          break;
        case HttpMethod.delete:
          response = await _client
              .delete(
                url,
                headers: headers,
                body: bodyString,
              )
              .timeout(const Duration(seconds: 120));
          break;
      }
      final statusCode = response.statusCode;

      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': statusCode,
        'responseBody': _parseResponseBody(response.body),
      };

      if (statusCode >= 200 && statusCode < 300) {
        final json = Map<String, dynamic>.from(jsonDecode(response.body));
        if (json['response']['id'] > 0) {
          return Either.right(response.body);
        }
        return Either.left(HttpFailure(statusCode: statusCode));
      }
      return Either.left(HttpFailure(statusCode: statusCode));
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        'exception': e.runtimeType.toString(),
        'stackTrace': stackTrace.toString(),
      };

      if (e is SocketException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    } finally {
      if (kDebugMode) {
        logs = {
          ...logs,
          'endTime': DateTime.now().toString(),
        };
        log(
          const JsonEncoder.withIndent(' ').convert(logs),
          stackTrace: stackTrace,
        );
      }
    }
  }
}
