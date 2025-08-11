import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/supplier_response_model.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supplier_repository.dart';

class SupplierProvider extends ChangeNotifier {
  final SupplierRepository _supplierRepository;

  SupplierProvider({required SupplierRepository supplierRepository})
      : _supplierRepository = supplierRepository;

  List<Supplier>? _suppliers;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<Supplier>? get suppliers => _suppliers;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchSuppliers(String fkPartnerLicence) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _supplierRepository.getSuppliers(fkPartnerLicence);

    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _suppliers = responseModel.suppliers;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
