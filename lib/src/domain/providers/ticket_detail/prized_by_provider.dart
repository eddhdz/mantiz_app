import 'package:flutter/material.dart';

import '../../../data/models/ticket_detail/prized_by_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/prized_by_repository.dart';

class PrizedByProvider extends ChangeNotifier {
  final PrizedByRepository _prizedByRepository;

  PrizedByProvider({required PrizedByRepository prizedByRepository})
      : _prizedByRepository = prizedByRepository;

  List<Costs>? _costs;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<Costs>? get costs => _costs;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchPrizedBy(int fkMaintenance) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _prizedByRepository.getPrices(fkMaintenance);
    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _costs = responseModel.maintenances;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
