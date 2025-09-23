import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../repositories/ticket_detail/price_repository.dart';

class PriceProvider extends ChangeNotifier {
  final PriceRepository _priceRepository;

  PriceProvider({required PriceRepository priceRepository})
      : _priceRepository = priceRepository;

  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchPriceTicket(
      int fkMaintenance, int createdByPartner, double price) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _priceRepository.price(fkMaintenance, createdByPartner, price);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (successId) {
      _status = DataStatus.success;
    });
    notifyListeners();
  }
}
