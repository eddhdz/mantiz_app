import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/done_repositroy.dart';

class DoneProvider extends ChangeNotifier {
  final DoneRepositroy _doneRepositroy;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DoneProvider({required DoneRepositroy doneRepositroy})
      : _doneRepositroy = doneRepositroy;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchDoneTicket(
    int ticketId,
    int userId,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  ) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _doneRepositroy.done(
      ticketId,
      userId,
      evidence,
      evidencePhoto,
      evidencePhoto360,
    );

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });

    notifyListeners();
  }
}
