import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assign_repository.dart';

class AssignProvider extends ChangeNotifier {
  final AssignRepository _assignRepository;

  AssignProvider({required AssignRepository assignRepository})
      : _assignRepository = assignRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> assignTicket(
      int fkMaintenance, int asignByPartner, int asignToTechnician) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _assignRepository.assign(
        fkMaintenance, asignByPartner, asignToTechnician);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
