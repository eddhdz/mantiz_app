import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/new_ticket/views/new_ticket_view.dart';

import '../pages/views.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.logIn: (context) => const LogInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.newTicket: (context) => const NewTicketView(),
  };
}
