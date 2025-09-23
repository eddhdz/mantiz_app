import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/ticket_detail/assigned_to_response_model.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assigned_to_repository.dart';

class AssignedToProvider extends ChangeNotifier {
  final AssignedToRepository _assignedToRepository;

  AssignedToProvider({required AssignedToRepository assignedToRepository})
      : _assignedToRepository = assignedToRepository;

  List<Maintenance>? _assigned;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<Maintenance>? get assigned => _assigned;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchAssignedTo(String fkMaintenance) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _assignedToRepository.getAssigned(fkMaintenance);
    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _assigned = responseModel.maintenances;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
