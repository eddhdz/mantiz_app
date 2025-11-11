import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/authentication/login_response_model.dart';
import 'package:mantiz/src/domain/providers/session/user_session_provider.dart';
import 'package:provider/provider.dart';

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

  Future<void> fetchIsSessionActive(BuildContext context,
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
      final UserModel userData = session.list.first.profile.user;
      final userSession = Provider.of<UserSessionProvider>(context,listen: false);
      userSession.setUser(userData);
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
