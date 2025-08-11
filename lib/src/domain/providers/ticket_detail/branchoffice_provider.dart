import 'package:flutter/material.dart';

import '../../../data/models/branchoffice_response_model.dart';
import '../../enums.dart';
import '../../repositories/ticket_detail/branchoffice_repository.dart';

class BranchofficeProvider extends ChangeNotifier {
  final BranchofficeRepository _branchofficeRepository;

  BranchofficeProvider({required BranchofficeRepository branchofficeRepository})
      : _branchofficeRepository = branchofficeRepository;

  List<BranchofficeData>? _branchoffices;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<BranchofficeData>? get branchoffices => _branchoffices;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchBranchoffices(String fkSupplier) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _branchofficeRepository.getBranchOffices(fkSupplier);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _branchoffices = responseModel.branchoffices;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
