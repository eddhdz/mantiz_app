import 'package:mantiz/src/data/repositories_implementation/ticket_detail/add_message_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/assign_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/assigned_to_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/branchoffice_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/schedule_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/supervisor_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/supplier_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/tracking_repository_impl.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/add_message_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/assign_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/assigned_to_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/branch_office_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/schedule_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/supervisor_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/suppliers_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/tracking_service.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/add_message_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/assign_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/assigned_to_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/branchoffice_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supervisor_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supplier_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/tracking_provider.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/add_message_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assign_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assigned_to_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/branchoffice_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/schedule_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supervisor_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supplier_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/tracking_repository.dart';

import '../data/http/http.dart';
import '../data/repositories_implementation/authentication/authentication_repository_impl.dart';
import '../data/repositories_implementation/connectivity/connectivity_repository_impl.dart';
import '../data/repositories_implementation/home/home_repository_impl.dart';
import '../data/repositories_implementation/licence/licence_repository_impl.dart';
import '../data/repositories_implementation/new_ticket/new_ticket_repository_impl.dart';
import '../data/services/remote/authentication/authentication_service.dart';
import '../data/services/remote/home/home_api.dart';
import '../data/services/remote/licence/licence_service.dart';
import '../data/services/remote/new_ticket/new_ticket_api.dart';
import '../domain/providers/licence/licence_provider.dart';
import '../domain/repositories/authentication/authentication_repository.dart';
import '../domain/repositories/connectivity/connectivity_repository.dart';
import '../domain/repositories/home/home_repository.dart';
import '../domain/repositories/licence/licence_repository.dart';
import '../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../presentation/constants/app_constants.dart';
import '../presentation/pages/home/views/home_view_vm.dart';
import '../presentation/pages/log_in/controller/log_in_controller.dart';
import '../presentation/pages/new_ticket/views/new_ticket_view_vm.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider.value(value: HomeViewVm()),

  ChangeNotifierProvider.value(value: NewTicketViewVM()),

  Provider<NewTicketRepository>(
      create: (_) => NewTicketRepositoryImpl(
          NewTicketApi(Http(http.Client(), AppConstants.baseUrl)),
          const FlutterSecureStorage())),
  // Repositorio para conexion
  Provider<ConnectivityRepository>(
    create: (_) => ConnectivityRepositoryImpl(Connectivity()),
  ),

  // Repositorio LogIn

  Provider<AuthenticationRepository>(
    create: (_) => AuthenticationRepositoryImpl(
      const FlutterSecureStorage(),
      AuthenticationService(Http(
        http.Client(),
        AppConstants.baseUrl,
      )),
    ),
  ),

  // Repositorio para la licencia

  Provider<LicenceRepository>(
    create: (_) => LicenceRepositoryImpl(
      LicenceService(
        Http(http.Client(), AppConstants.baseUrl),
      ),
    ),
  ),

  ChangeNotifierProvider<LicenceProvider>(
    create: (context) => LicenceProvider(context.read<LicenceRepository>()),
  ),

  ChangeNotifierProvider<LogInController>(
    create: (context) => LogInController(
      context.read<AuthenticationRepository>(),
    ),
  ),

  Provider<HomeRepository>(
    create: (_) => HomeRepositoryImpl(
        HomeApi(Http(
          http.Client(),
          AppConstants.baseUrl,
        )),
        const FlutterSecureStorage()),
  ),

  // Repositorio para verificar si el ticket esta asignado

  Provider<AssignedToRepository>(
    create: (context) => AssignedToRepositoryImpl(
      assignedToService: AssignedToService(
        http: Http(http.Client(), AppConstants.baseUrl),
      ),
    ),
  ),

  ChangeNotifierProvider<AssignedToProvider>(
    create: (context) => AssignedToProvider(
        assignedToRepository: context.read<AssignedToRepository>()),
  ),

  // Repositorio para cargar proveedores en el detalle del ticket

  Provider<SupplierRepository>(
    create: (context) => SupplierRepositoryImpl(
      suppliersService: SuppliersService(
        http: Http(http.Client(), AppConstants.baseUrl),
      ),
    ),
  ),

  ChangeNotifierProvider<SupplierProvider>(
    create: (context) => SupplierProvider(
        supplierRepository: context.read<SupplierRepository>()),
  ),

  // Repositorio para cargar las sucursales en el detalle del ticket

  Provider<BranchofficeRepository>(
    create: (context) => BranchofficeRepositoryImpl(
        branchofficeService: BranchofficeService(
            http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<BranchofficeProvider>(
    create: (context) => BranchofficeProvider(
        branchofficeRepository: context.read<BranchofficeRepository>()),
  ),

  // Repositorio para cargar los supervisores en el detalle del ticket

  Provider<SupervisorRepository>(
    create: (context) => SupervisorRepositoryImpl(
        supervisorService:
            SupervisorService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<SupervisorProvider>(
    create: (context) => SupervisorProvider(
        supervisorRepository: context.read<SupervisorRepository>()),
  ),

  // Repositorio para asignar el ticket

  Provider<AssignRepository>(
    create: (context) => AssignRepositoryImpl(
        assignService:
            AssignService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<AssignProvider>(
    create: (context) =>
        AssignProvider(assignRepository: context.read<AssignRepository>()),
  ),

  // Repositorio para agregar un mensaje al ticket

  Provider<AddMessageRepository>(
    create: (context) => AddMessageRepositoryImpl(
        addMessageService:
            AddMessageService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<AddMessageProvider>(
    create: (context) => AddMessageProvider(
        addMessageRepository: context.read<AddMessageRepository>()),
  ),

  // Repositorio para cargar mensajes de seguimiento

  Provider<TrackingRepository>(
    create: (context) => TrackingRepositoryImpl(
        trackingService:
            TrackingService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<TrackingProvider>(
    create: (context) => TrackingProvider(
        trackingRepository: context.read<TrackingRepository>()),
  ),

  // Repositorio para agendar un ticket

  Provider<ScheduleRepository>(
    create: (context) => ScheduleRepositoryImpl(
        scheduleService:
            ScheduleService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<ScheduleProvider>(
    create: (context) => ScheduleProvider(
        scheduleRepository: context.read<ScheduleRepository>()),
  ),
];
