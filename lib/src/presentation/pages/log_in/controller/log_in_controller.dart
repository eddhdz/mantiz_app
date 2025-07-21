import 'package:flutter/foundation.dart';

class LogInController extends ChangeNotifier {
  String _userName = '', _password = '';
  bool _fetching = false, _mounted = true;

  String get username => _userName;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;

  void onUserNameChanged(String text) {
    _userName = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
  }

  void onFetchingChanged(bool value) {
    _fetching = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
