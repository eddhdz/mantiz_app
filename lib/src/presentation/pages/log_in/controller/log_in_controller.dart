import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';

class LogInController extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final FirebaseMessaging _fbm;
  final FlutterSecureStorage _secureStorage;

  String _userName = '', _password = '';
  bool _fetching = false, _mounted = true, _isVisible = false;

  LogInController(
      {required AuthenticationRepository authenticationRepository,
      required FirebaseMessaging fbm,
      required FlutterSecureStorage secureStorage})
      : _authenticationRepository = authenticationRepository,
        _fbm = fbm,
        _secureStorage = secureStorage;

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

    if (firebasetoken == null) {
      onFetchingChanged(false);
      _showErrorSnackBar(
          context, 'No se pudo obtener el token.Intenta de nuevo');
      return;
    }

    String timestamp = DateTime.now().toUtc().toIso8601String();
    String combinedData = '$firebasetoken$timestamp';
    List<int> bytes = utf8.encode(combinedData);
    final String mobileUuid = md5.convert(bytes).toString();

    final result = await _authenticationRepository.signIn(
        _userName, _password, mobileUuid, firebasetoken);

    result.when((failure) {
      onFetchingChanged(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ),
      );
    }, (userEntity) async {
      _secureStorage.write(key: 'mobileuuid', value: mobileUuid);
      _secureStorage.write(key: 'firebasetoken', value: firebasetoken);
      Navigator.pushReplacementNamed(context, Routes.startingPoint);
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    if (_mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
