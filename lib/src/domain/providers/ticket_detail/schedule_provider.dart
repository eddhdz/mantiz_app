import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/ticket_detail/schedule_repository.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository _scheduleRepository;

  ScheduleProvider({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> scheduleTicket(int fkMaintenance, int scheduleByPartner,
      int atentionTime, String atentionAt) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _scheduleRepository.schedule(
        fkMaintenance, scheduleByPartner, atentionTime, atentionAt);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
