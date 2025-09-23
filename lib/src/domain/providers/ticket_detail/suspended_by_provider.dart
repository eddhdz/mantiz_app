import 'package:flutter/material.dart';

import '../../../data/models/ticket_detail/suspended_by_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/suspended_by_repository.dart';

class SuspendedByProvider extends ChangeNotifier {
  final SuspendedByRepository _suspendedByRepository;

  SuspendedByProvider({required SuspendedByRepository suspendedByRepository})
      : _suspendedByRepository = suspendedByRepository;

  List<Suspensions>? _suspensions;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<Suspensions>? get suspensions => _suspensions;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchSuspendedBy(int fkMaintenance) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _suspendedByRepository.getSuspensionInfo(fkMaintenance);
    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _suspensions = responseModel.maintenances;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
