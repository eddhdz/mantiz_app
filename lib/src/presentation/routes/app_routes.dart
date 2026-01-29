import 'package:flutter/material.dart';

import '../../data/models/ticket_model.dart';
import '../pages/home_redesign/home_redesign_view.dart';
import '../pages/new_ticket_redesign/new_ticket_redesign_view.dart';
import '../pages/starting_point.dart/view/starting_point_view.dart';
import '../pages/ticket_detail/views/validation_view.dart';
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
    // case Routes.home:
    //   return MaterialPageRoute(
    //     builder: (_) => const HomeView(),
    //   );
    case Routes.home:
      return MaterialPageRoute(
        builder: (_) => const HomeRedesignView(),
      );
    case Routes.newTicket:
      return MaterialPageRoute(
        builder: (_) => const NewTicketRedesignView(),
      );

    // case Routes.newTicket:
    //   return MaterialPageRoute(
    //     builder: (_) => const NewTicketView(),
    //   );

    case Routes.startingPoint:
      return MaterialPageRoute(
        builder: (_) => const StartingPointView(),
      );

    // case Routes.first_page:
    //   return MaterialPageRoute(
    //     builder: (_) => const FirstPageView(maintenances: []),
    //   );
    // case Routes.second_page:
    //   return MaterialPageRoute(
    //     builder: (_) => const SecondPageView(branchOffices: []),
    //   );
    // case Routes.third_page:
    //   return MaterialPageRoute(
    //     builder: (_) => const ThirdPageView(tickets: []),
    //   );

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
    case Routes.validation:
      if (args is List && args.length >= 2) {
        final int ticketId = args[0] as int;
        final int userId = args[1] as int;
        return MaterialPageRoute(
          builder: (_) => ValidationView(ticketId: ticketId, userId: userId),
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
