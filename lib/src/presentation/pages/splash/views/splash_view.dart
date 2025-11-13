import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/providers/session/session_provider.dart';
import 'package:mantiz/src/domain/repositories/session/session_repository.dart';

import '../../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../../global/colors.dart';
import '../../../../domain/repositories/connectivity/connectivity_repository.dart';

import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  Future<void> _init() async {
    final connectivityRepository = Provider.of<ConnectivityRepository>(
      context,
      listen: false,
    );

    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final sessionRepository =
        Provider.of<SessionProvider>(context, listen: false);
    final hasInternet = await connectivityRepository.hasInternet;
    final mobileUuid = await secureStorage.read(key: 'mobileuuid');
    final firebaseToken = await secureStorage.read(key: 'firebasetoken');

    await Future.delayed(const Duration(seconds: 2));

    if (hasInternet) {
      if (mobileUuid == null || firebaseToken == null) {
        _goTo(Routes.logIn);
      } else {
        await sessionRepository.fetchIsSessionActive(
          context,
          mobileUuid,
          firebaseToken,
        );
        if (sessionRepository.status == DataStatus.success) {
          _goTo(Routes.startingPoint);
        } else {
          _goTo(Routes.logIn);
        }
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: sidonGreenDark,
      body: Center(
        child: Text('MANTIZ',
            style: TextStyle(
              color: veryLightGray,
              fontSize: 40,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}
