import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/profile_response_model.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supervisor_repository.dart';

class SupervisorProvider extends ChangeNotifier {
  final SupervisorRepository _supervisorRepository;

  SupervisorProvider({required SupervisorRepository supervisorRepository})
      : _supervisorRepository = supervisorRepository;

  List<ProfileData> _supervisors = [];
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  List<ProfileData> get supervisors => _supervisors;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchSupervisors(String fkSBO) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _supervisorRepository.getSupervisors(fkSBO);

    result.when(
      (failure) {
        _errorMessage = failure;
        _status = DataStatus.error;
        _supervisors = [];
      },
      (responseModel) {
        _supervisors = responseModel.profiles
            .where((profile) => profile.typerole == "2-Supervisor")
            .toList();

        if (_supervisors.isEmpty) {
          _status = DataStatus.noData;
        } else {
          _status = DataStatus.loaded;
        }
      },
    );
    notifyListeners();
  }
}
