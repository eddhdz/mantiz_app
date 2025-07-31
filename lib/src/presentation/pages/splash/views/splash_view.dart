import 'package:flutter/material.dart';

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
    final authenticationRepository = Provider.of<AuthenticationRepository>(
      context,
      listen: false,
    );
    final hasInternet = await connectivityRepository.hasInternet;
    await Future.delayed(const Duration(seconds: 2));

    if (hasInternet) {
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.logIn);
          }
        }
      } else if (mounted) {
        _goTo(Routes.logIn);
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
      backgroundColor: darkGray,
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
