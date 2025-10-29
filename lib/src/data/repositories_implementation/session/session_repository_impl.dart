import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

import '../../../domain/repositories/session/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final FlutterSecureStorage _secureStorage;
  final FirebaseMessaging _fbm;

  SessionRepositoryImpl(
      {required FlutterSecureStorage secureStorage,
      required FirebaseMessaging fbm})
      : _secureStorage = secureStorage,
        _fbm = fbm;

  @override
  Future<bool> get isSessionActive async {
    final mobileUuid = await _secureStorage.read(key: 'mobileuuid');
    if (mobileUuid == null) {
      return false;
      // final token = await getFBMToken();
      // String timestamp = DateTime.now().toUtc().toIso8601String();
      // String combinedData = '$token$timestamp';
      // List<int> bytes = utf8.encode(combinedData);
      // Digest md5Hash = md5.convert(bytes);
    }
    return true;
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
}
