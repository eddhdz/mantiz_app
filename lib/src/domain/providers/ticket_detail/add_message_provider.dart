import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/ticket_detail/add_message_repository.dart';

class AddMessageProvider extends ChangeNotifier {
  final AddMessageRepository _addMessageRepository;

  AddMessageProvider({required AddMessageRepository addMessageRepository})
      : _addMessageRepository = addMessageRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> addMessage(
      int fkMaintenance, int fkProfile, String message) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _addMessageRepository.addMessage(
        fkMaintenance, fkProfile, message);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
  }
}
