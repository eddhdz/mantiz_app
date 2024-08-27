import 'package:flutter/material.dart';
import 'package:mantiz/src/data/repositories_implementation/home/home_repository_impl.dart';
import 'package:mantiz/src/data/services/remote/home/home_api.dart';
import 'package:mantiz/src/domain/repositories/home/home_repository.dart';
import 'package:mantiz/src/presentation/pages/home/views/home_view_vm.dart';

import 'src/data/http/http.dart';
import 'src/data/repositories_implementation/authentication_repository_impl.dart';
import 'src/data/repositories_implementation/connectivity_repository_impl.dart';
import 'src/data/services/remote/authentication_api.dart';
import 'src/data/services/remote/base_url.dart';
import 'src/domain/repositories/authentication_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/routes/routes.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider.value(value: HomeViewVm())],
      child: Injector(
          connectivityRepository: ConnectivityRepositoryImpl(Connectivity()),
          authenticationRepository: AuthenticationRepositoryImpl(
            const FlutterSecureStorage(),
            AuthenticationApi(Http(
              http.Client(),
              BaseUrl.baseUrl,
            )),
          ),
          homeRepository: HomeRepositoryImpl(HomeApi(Http(
            http.Client(),
            BaseUrl.baseUrl,
          ))),
          child: const MyApp())));
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
      required this.authenticationRepository,
      required this.homeRepository});

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;
  final HomeRepository homeRepository;

  @override
  // ignore: avoid_renaming_method_parameters
  bool updateShouldNotify(_) => false;
  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
