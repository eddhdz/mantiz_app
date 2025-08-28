import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/suspend_repository.dart';

class SuspendProvider extends ChangeNotifier {
  final SuspendRepository _suspendRepository;

  SuspendProvider({required SuspendRepository suspendRepository})
      : _suspendRepository = suspendRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchSuspendTicket(
      int fkMaintenance, int suspendByPartner, String reason) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _suspendRepository.suspend(
        fkMaintenance, suspendByPartner, reason);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
