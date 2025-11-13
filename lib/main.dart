import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/push_notifications/push_notifications_service.dart';

import 'src/injection/providers.dart';
import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/routes/routes.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Push notifications service ...
  await PushNotificationService.initializeApp();

  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  PushNotificationService.messageBody.listen((message) {
    final snackBar = SnackBar(content: Text(message));
    messengerKey.currentState?.showSnackBar(snackBar);
  });

  // await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: appProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
