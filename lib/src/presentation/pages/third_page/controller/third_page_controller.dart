import 'package:flutter/material.dart';

import '../../../../data/models/ticket_model.dart';

class ThirdPageController extends ChangeNotifier {
  List<TicketModel> allTickets = [];
  List<TicketModel> visibleTickets = [];
  bool isLoading = false;

  ThirdPageController(List<TicketModel> initialTickets) {
    allTickets = List.from(initialTickets);
    visibleTickets = List.from(allTickets);

    visibleTickets.sort((a, b) => b.ticketId.compareTo(a.ticketId));
  }

  void applyFilter(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      visibleTickets = List.from(allTickets);
      visibleTickets.sort((a, b) => b.ticketId.compareTo(a.ticketId));

      notifyListeners();
      return;
    }

    visibleTickets = allTickets.where((t) {
      final reason = t.reason.toString().toLowerCase();
      final ticketId = t.ticketId.toString().toLowerCase();
      final folio = t.folio.toLowerCase();
      final title = (t.title ?? '').toLowerCase();
      final type = t.type.toLowerCase();
      final area = t.area.toLowerCase();
      final status = t.status.toLowerCase();

      return ticketId.contains(q) || folio.contains(q) || title.contains(q) || type.contains(q) || area.contains(q) || status.contains(q) || reason.contains(q);
    }).toList();

    //! Ordenamos la lista por "ticketId" ...
    visibleTickets.sort((a, b) => b.ticketId.compareTo(a.ticketId));

    notifyListeners();
  }

  void resetFilter() {
    visibleTickets = List.from(allTickets);

    visibleTickets.sort((a, b) => b.ticketId.compareTo(a.ticketId));
    notifyListeners();
  }
}
