import 'package:flutter/foundation.dart';

import '../../../data/models/ticket_detail/ticket_list_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/detail_repository.dart';

class DetailProvider extends ChangeNotifier {
  final DetailRepository _detailRepository;

  DetailProvider({required DetailRepository detailRepository})
      : _detailRepository = detailRepository;

  TicketDetailModel? _detail;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  TicketDetailModel? get detail => _detail;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchDetail(int ticketId) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _detailRepository.getDetail(ticketId);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _detail = responseModel.list.first;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
