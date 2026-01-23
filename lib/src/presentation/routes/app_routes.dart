import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/first_page/view/first_page_view.dart';
import 'package:mantiz/src/presentation/pages/second_page/view/second_page_view.dart';
import 'package:mantiz/src/presentation/pages/starting_point.dart/view/starting_point_view.dart';
import 'package:mantiz/src/presentation/pages/third_page/view/third_page_view.dart';

import '../../data/models/models.dart';
import '../../data/models/ticket_model.dart';
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
    case Routes.startingPoint:
      return MaterialPageRoute(
        builder: (_) => const StartingPointView(),
      );
    case Routes.first_page:
      return MaterialPageRoute(
        builder: (_) => const FirstPageView(maintenances: []),
      );
    case Routes.second_page:
      return MaterialPageRoute(
        builder: (_) => const SecondPageView(branchOffices: []),
      );
    case Routes.third_page:
      return MaterialPageRoute(
        builder: (_) => const ThirdPageView(tickets: []),
      );

    case Routes.detailTicket:
      if (settings.arguments is TicketModel) {
        final TicketModel ticket = settings.arguments as TicketModel;
        return MaterialPageRoute(
          builder: (_) => DetailTicketView(ticket: ticket),
        );
      }

      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Error: parametro de ticket no encontrado'),
          ),
        ),
      );
    case Routes.trackingTicket:
      if (args is List && args.length >= 3) {
        final int fkMaintenance = args[0] as int;
        final int currentUserId = args[1] as int;
        final String folio = args[2] as String;
        return MaterialPageRoute(
          builder: (_) => TicketTrackingView(
            fkMaintenance: fkMaintenance,
            currentUserId: currentUserId,
            folio: folio,
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
