import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';

class LogInController extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final FirebaseMessaging _fbm;

  String _userName = '', _password = '';
  bool _fetching = false, _mounted = true, _isVisible = false;

  LogInController(
      {required AuthenticationRepository authenticationRepository,
      required FirebaseMessaging fbm})
      : _authenticationRepository = authenticationRepository,
        _fbm = fbm;

  String get username => _userName;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;
  bool get isVisible => _isVisible;

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

  void onVisibleChanged() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  Future<String?> getFBMToken() async {
    try {
      NotificationSettings settings =
          await _fbm.requestPermission(alert: true, badge: true, sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        String? token = await _fbm.getToken();
        if (token != null) {
          return token;
        }
        token = await _fbm.onTokenRefresh.first;
        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> submitLogin(BuildContext context) async {
    if (fetching) return;

    onFetchingChanged(true);
    String? firebasetoken = await getFBMToken();
    String timestamp = DateTime.now().toUtc().toIso8601String();
    String combinedData = '$firebasetoken$timestamp';
    List<int> bytes = utf8.encode(combinedData);
    Digest mobileUuid = md5.convert(bytes);

    final result = await _authenticationRepository.signIn(
        _userName, _password, mobileUuid.toString(), firebasetoken);
    result.when((failure) {
      onFetchingChanged(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ),
      );
    }, (userEntity) async {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
