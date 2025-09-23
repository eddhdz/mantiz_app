import 'package:flutter/material.dart';

import '../../../data/models/ticket_detail/schedule_for_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/schedule_for_repository.dart';

class ScheduleForProvider extends ChangeNotifier {
  final ScheduleForRepository _scheduleForRepository;

  ScheduleForProvider({required ScheduleForRepository scheduleForRepository})
      : _scheduleForRepository = scheduleForRepository;

  List<Maintenance>? _scheduled;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<Maintenance>? get scheduled => _scheduled;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchScheduleFor(int fkMaintenance) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _scheduleForRepository.getScheduled(fkMaintenance);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _scheduled = responseModel.maintenances;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
