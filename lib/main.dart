import 'package:flutter/material.dart';

import 'src/data/repositories_implementation/authentication_repository_impl.dart';
import 'src/data/repositories_implementation/connectivity_repository_impl.dart';
import 'src/domain/repositories/authentication_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/routes/routes.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(Injector(
      connectivityRepository: ConnectivityRepositoryImpl(Connectivity()),
      authenticationRepository: AuthenticationRepositoryImpl(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}

class Injector extends InheritedWidget {
  const Injector(
      {super.key,
      required super.child,
      required this.connectivityRepository,
      required this.authenticationRepository});

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  // ignore: avoid_renaming_method_parameters
  bool updateShouldNotify(_) => false;
  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
