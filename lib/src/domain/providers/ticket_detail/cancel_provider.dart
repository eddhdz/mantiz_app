import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/ticket_detail/cancel_repository.dart';

class CancelProvider extends ChangeNotifier {
  final CancelRepository _cancelRepository;

  CancelProvider({required CancelRepository cancelRepository})
      : _cancelRepository = cancelRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchCancelTicket(
      int fkMaintenance, int cancelByPartner, String reason) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _cancelRepository.cancel(fkMaintenance, cancelByPartner, reason);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });

    notifyListeners();
  }
}
