import 'package:flutter/foundation.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/activate_repository.dart';

class ActivateProvider extends ChangeNotifier {
  final ActivateRepository _activateRepository;

  ActivateProvider({required ActivateRepository activateRepository})
      : _activateRepository = activateRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> activateTicket(
    int fkMaintenance,
    int openByPartner,
  ) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _activateRepository.activate(fkMaintenance, openByPartner);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
