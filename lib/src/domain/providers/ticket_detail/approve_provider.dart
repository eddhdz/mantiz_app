import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/ticket_detail/approve_repository.dart';

class ApproveProvider extends ChangeNotifier {
  final ApproveRepository _approveRepository;

  ApproveProvider({required ApproveRepository approveRepository})
      : _approveRepository = approveRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchApproveTicket(
    int ticketId,
    int userId,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  ) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _approveRepository.approve(
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
