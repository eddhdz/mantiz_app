import 'package:flutter/material.dart';

import '../pages/views.dart';
import 'routes.dart';

// Map<String, Widget Function(BuildContext)> get appRoutes {
//   return {
//     Routes.splash: (context) => const SplashView(),
//     Routes.logIn: (context) => const LogInView(),
//     Routes.home: (context) => const HomeView(),
//     Routes.offline: (context) => const OfflineView(),
//     Routes.newTicket: (context) => const NewTicketView(),
//   };
// }

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(
        builder: (_) => const SplashView(),
      );
    case Routes.offline:
      return MaterialPageRoute(
        builder: (_) => const OfflineView(),
      );
    case Routes.logIn:
      return MaterialPageRoute(
        builder: (_) => const LogInView(),
      );
    case Routes.home:
      return MaterialPageRoute(
        builder: (_) => const HomeView(),
      );
    case Routes.newTicket:
      return MaterialPageRoute(
        builder: (_) => const NewTicketView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('404: Page not found'),
          ),
        ),
      );
  }
}
