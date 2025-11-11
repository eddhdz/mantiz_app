import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/authentication/login_response_model.dart';

class UserSessionProvider extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}
