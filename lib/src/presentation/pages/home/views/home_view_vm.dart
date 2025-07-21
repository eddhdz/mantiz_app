import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/models/maintenances_model.dart';
import '../../../../domain/repositories/home/home_repository.dart';

import 'package:provider/provider.dart';

class HomeViewVm with ChangeNotifier {
  List<MaintenancesModel> allTickets = [];

  List<MaintenancesModel> _visibleTickets = [];
  List<MaintenancesModel> get visibleTickets => _visibleTickets;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadAllTickets(BuildContext context) async {
    _isLoading = true;
    allTickets = [];
    _visibleTickets = [];
    notifyListeners();

    final result = await Provider.of<HomeRepository>(context, listen: false)
        .loadMaintenances();

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }, (maintenances) {
      _visibleTickets = allTickets = maintenances;
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> filterTickets(BuildContext context, String value) async {
    _isLoading = true;
    _visibleTickets = [];
    notifyListeners();

    _visibleTickets = allTickets
        .where((ticket) =>
            ticket.description.toLowerCase().contains(value.toLowerCase()) ||
            ticket.customer.toLowerCase().contains(value.toLowerCase()) ||
            ticket.status.toLowerCase().contains(value.toLowerCase()))
        .toList();

    _isLoading = false;
    notifyListeners();
  }
}
