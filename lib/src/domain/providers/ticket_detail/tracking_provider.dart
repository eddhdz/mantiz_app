import 'package:flutter/material.dart';

import '../../../data/models/ticket_detail/message_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/tracking_repository.dart';

class TrackingProvider extends ChangeNotifier {
  final TrackingRepository _trackingRepository;

  TrackingProvider({required TrackingRepository trackingRepository})
      : _trackingRepository = trackingRepository;

  List<ChatMessageModel>? _messages;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<ChatMessageModel>? get messages => _messages;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchMessages(int ticketId) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _trackingRepository.getTrackingMessages(ticketId);

    result.when((failure) {
      _errorMessage = failure;
      if (failure == GeneralFailure.empty) {
        _status = DataStatus.noData;
      } else {
        _status = DataStatus.error;
      }
    }, (responseModel) {
      _messages = responseModel.list.first.chat;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
