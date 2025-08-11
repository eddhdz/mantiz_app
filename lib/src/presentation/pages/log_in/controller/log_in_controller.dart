import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/providers/licence/licence_provider.dart';
import '../../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';

import 'package:provider/provider.dart';

class LogInController extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;

  String _userName = '', _password = '';
  bool _fetching = false, _mounted = true, _isVisible = false;

  String get username => _userName;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;
  bool get isVisible => _isVisible;

  LogInController(this._authenticationRepository);

  void onUserNameChanged(String text) {
    _userName = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
  }

  void onFetchingChanged(bool value) {
    _fetching = value;
    notifyListeners();
  }

  void onVisibleChanged() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  Future<void> submitLogin(BuildContext context) async {
    if (fetching) return;

    onFetchingChanged(true);

    final result = await _authenticationRepository.signIn(_userName, _password);
    result.when((failure) {
      onFetchingChanged(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error inesperado'),
        ),
      );
    }, (userEntity) async {
      // final licenceProvider = context.read<LicenceProvider>();
      final licenceProvider =
          Provider.of<LicenceProvider>(context, listen: false);
      final String fkPartner = jsonDecode(userEntity)['fkPartner'].toString();

      await licenceProvider.fetchUserLicences(fkPartner);
      onFetchingChanged(false);

      if (licenceProvider.status == LicenceStatus.loaded &&
          licenceProvider.isLicenceActive) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        String licenceErrorMessage = "Licencia inválida o no activa.";
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(licenceErrorMessage)),
        );
      }
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
