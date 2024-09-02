part of 'http.dart';

class HttpFailure {
  final int? statusCode;
  final Object? exception;

  HttpFailure({
    this.statusCode,
    this.exception,
  });
}

class NetworkException {}
