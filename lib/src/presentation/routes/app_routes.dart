import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import '../pages/views.dart';
import 'routes.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;
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
    case Routes.detailTicket:
      if (settings.arguments is MaintenancesModel) {
        final MaintenancesModel maintenance =
            settings.arguments as MaintenancesModel;
        return MaterialPageRoute(
          builder: (_) => DetailTicketView(maintenance: maintenance),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error: parametro de ticket no encontrado'),
          ),
        ),
      );
    case Routes.trackingTicket:
      if (args is List && args.length >= 2) {
        final int fkMaintenance = args[0] as int;
        final int currentUserId = args[1] as int;
        return MaterialPageRoute(
          builder: (_) => TicketTrackingView(
            fkMaintenance: fkMaintenance,
            currentUserId: currentUserId,
          ),
        );
      }
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
