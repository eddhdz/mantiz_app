import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../firebase_options.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static final StreamController<String> _messageBody = StreamController.broadcast();
  static Stream<String> get messageBody => _messageBody.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _messageBody.add('${message.notification?.title}: ${message.notification?.body}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    _messageBody.add('${message.notification?.title}: ${message.notification?.body}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    await Firebase.initializeApp();

    _messageBody.add('${message.notification?.title}: ${message.notification?.body}');
  }

  static Future<bool> initializeApp() async {
    bool funciono = false;

    try {
      if (Platform.isIOS) {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).whenComplete(() async {
          funciono = await cargaListener();
        });
      } else {
        await Firebase.initializeApp().whenComplete(() async {
          funciono = await cargaListener();
        });
      }
    } catch (e) {
      funciono = false;
    }

    return funciono;
  }

  static Future<bool> cargaListener() async {
    bool regreso = false;

    try {
      AuthorizationStatus status = await requestPermission();

      if (status == AuthorizationStatus.authorized) {
        token = await FirebaseMessaging.instance.getToken();
        // PreferencesResources.tokenFirebase = token ?? '';
        // print('mi token push es: <$token> pushNotifService');

        //Handlers...
        FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

        FirebaseMessaging.onMessage.listen(_onMessageHandler, onDone: () {}, onError: (error) {
          throw Exception(error);
        });

        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp, onDone: () {}, onError: (error) {
          throw Exception(error);
        });

        // Local notifications...

        regreso = true;
      }
    } catch (e) {
      regreso = false;
    }

    return regreso;
  }

  // Apple / Web
  static Future<AuthorizationStatus> requestPermission() async {
    NotificationSettings settings =
        await messaging.requestPermission(alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true);

    return settings.authorizationStatus;
  }

  static closeStreams() {
    _messageBody.close();
  }
}
