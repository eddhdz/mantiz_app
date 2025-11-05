import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/session/logout_repository.dart';

class LogoutProvider extends ChangeNotifier {
  final LogoutRepository _logoutRepository;

  LogoutProvider({required LogoutRepository logoutRepository})
      : _logoutRepository = logoutRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchLogOut() async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _logoutRepository.logout();

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (success) {
      _status = DataStatus.success;
    });

    notifyListeners();
  }
}
