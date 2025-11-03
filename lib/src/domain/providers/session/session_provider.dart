import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/session/session_repository.dart';

class SessionProvider extends ChangeNotifier {
  final SessionRepository _sessionRepository;

  SessionProvider({required SessionRepository sessionRepository})
      : _sessionRepository = sessionRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchIsSessionActive(
      String mobileUuid, String firebaseToken) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _sessionRepository.isSessionActive(mobileUuid, firebaseToken);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (session) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
