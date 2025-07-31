import 'package:flutter/material.dart';

import '../../data/models/user_licence_response_model.dart';
import '../enums.dart';
import '../repositories/licence/licence_repository.dart';

class LicenceProvider extends ChangeNotifier {
  final LicenceRepository _licenceRepository;

  LicenceProvider(this._licenceRepository);

  UserLicence? _currentLicence;
  LicenceStatus _status = LicenceStatus.initial;
  GeneralFailure? _errorMessage;

  UserLicence? get currentLicence => _currentLicence;
  LicenceStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  bool get isLicenceActive =>
      _currentLicence?.active == 1 &&
      _currentLicence!.endAt.isAfter(DateTime.now());

  Future<void> fetchUserLicences(String fkPartner) async {
    _status = LicenceStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _licenceRepository.getUserLicence(fkPartner);

    result.when((failure) {
      _errorMessage = failure;
      _status = LicenceStatus.error;
    }, (responseModel) {
      if (responseModel.licences.isNotEmpty) {
        _currentLicence = responseModel.licences.firstWhere(
          (lic) => lic.active == 1 && lic.endAt.isAfter(DateTime.now()),
          orElse: () => responseModel.licences.first,
        );
      } else {
        _currentLicence = null;
        _errorMessage = GeneralFailure.noData;
      }
      _status = LicenceStatus.loaded;
    });
    notifyListeners();
  }
}
