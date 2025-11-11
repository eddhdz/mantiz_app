import 'package:flutter/material.dart';

import '../../first_page/view/first_page_view.dart';
import '../../second_page/view/second_page_view.dart';
import '../../third_page/view/third_page_view.dart';
import '../../../../data/models/maintenances_model.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/repositories/starting_point/starting_point_repository.dart';

import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StartingPointController with ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage();

  List<MaintenancesModel> _allMaintenances = [];
  List<MaintenancesModel> get allMaintenances => _allMaintenances;

  String _showMessage = '';
  String get showMessage => _showMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadAllMaintenance(BuildContext context) async {
    _showMessage = 'Espere, estamos cargando su información ...';
    _isLoading = true;
    notifyListeners();

    final typeuser = await _secureStorage.read(key: 'typeuser');
    final typerole = await _secureStorage.read(key: 'typerol');

    final result = await Provider.of<StartingPointRepository>((context.mounted) ? context : context, listen: false).loadMaintenances();

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'No records found',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (maintenances) {
      if (typeuser == null) {
        _showMessage = 'El usuario no tiene cargado tipo ...';
      } else if (typerole == null) {
        _showMessage = 'El usuario no tiene cargado rol ...';
      } else if (maintenances.isEmpty) {
        _showMessage = 'Sin información para el usuario ...';
      } else {
        _allMaintenances = maintenances;

        _showMessage = 'Puedes recargar pantalla ...';
        _isLoading = false;
        notifyListeners();

        if (typeuser.toLowerCase() == 'administrator' || typeuser.toLowerCase() == 'partner') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FirstPageView(maintenances: _allMaintenances)));
        } else if (typeuser.toLowerCase() == 'customer') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPageView(branchOffices: _allMaintenances[0].branchoffices)));
        } else if (typeuser.toLowerCase() == 'supplier' && typerole.toLowerCase() == 'tecnico') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ThirdPageView(tickets: _allMaintenances[0].branchoffices[0].tickets)));
        } else if (typeuser.toLowerCase() == 'supplier') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPageView(branchOffices: _allMaintenances[0].branchoffices)));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FirstPageView(maintenances: _allMaintenances)));
        }
      }

      _isLoading = false;
    });

    notifyListeners();
  }
}
