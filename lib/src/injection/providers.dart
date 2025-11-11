import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mantiz/src/data/repositories_implementation/session/logout_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/session/session_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/starting_point/starting_point_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/activate_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/add_message_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/approve_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/assign_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/assigned_to_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/branchoffice_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/cancel_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/done_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/price_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/prized_by_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/schedule_for_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/schedule_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/supervisor_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/supplier_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/suspend_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/suspended_by_repository_impl.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/tracking_repository_impl.dart';
import 'package:mantiz/src/data/services/remote/session/logout_service.dart';
import 'package:mantiz/src/data/services/remote/session/session_service.dart';
import 'package:mantiz/src/data/services/remote/starting_point/starting_point_api.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/activate_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/add_message_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/approve_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/assign_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/assigned_to_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/branch_office_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/cancel_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/detail_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/done_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/price_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/prized_by_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/schedule_for_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/schedule_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/supervisor_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/suppliers_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/suspend_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/suspended_by_service.dart';
import 'package:mantiz/src/data/services/remote/ticket_detail/tracking_service.dart';
import 'package:mantiz/src/domain/providers/session/logout_provider.dart';
import 'package:mantiz/src/domain/providers/session/session_provider.dart';
import 'package:mantiz/src/domain/providers/session/user_session_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/activate_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/add_message_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/approve_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/assign_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/assigned_to_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/branchoffice_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/cancel_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/detail_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/done_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/price_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/prized_by_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_for_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supervisor_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supplier_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/suspend_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/suspended_by_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/tracking_provider.dart';
import 'package:mantiz/src/domain/repositories/session/logout_repository.dart';
import 'package:mantiz/src/domain/repositories/session/session_repository.dart';
import 'package:mantiz/src/domain/repositories/starting_point/starting_point_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/activate_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/add_message_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/approve_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assign_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/assigned_to_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/branchoffice_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/cancel_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/detail_repository.dart';
import 'package:mantiz/src/data/repositories_implementation/ticket_detail/detail_repository_impl.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/done_repositroy.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/price_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/prized_by_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/schedule_for_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/schedule_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supervisor_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/supplier_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/suspend_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/suspended_by_repository.dart';
import 'package:mantiz/src/domain/repositories/ticket_detail/tracking_repository.dart';
import 'package:mantiz/src/presentation/pages/first_page/controller/first_page_controller.dart';
import 'package:mantiz/src/presentation/pages/starting_point.dart/controller/starting_point_controller.dart';
import 'package:mantiz/src/presentation/pages/third_page/controller/third_page_controller.dart';

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
  ChangeNotifierProvider.value(value: FirstPageController()),
  ChangeNotifierProvider.value(value: ThirdPageController([])),

  Provider<NewTicketRepository>(
      create: (_) => NewTicketRepositoryImpl(
            NewTicketApi(Http(http.Client(), AppConstants.testUrl)),
            const FlutterSecureStorage(),
          )),

  // Repositorio para conexion
  Provider<ConnectivityRepository>(
    create: (_) => ConnectivityRepositoryImpl(Connectivity()),
  ),

  //Repositorio para revisar la sesion
  Provider<SessionRepository>(
    create: (context) => SessionRepositoryImpl(
        sessionService: SessionService(
      http: Http(http.Client(), AppConstants.testUrl),
      deviceInfoPlugin: DeviceInfoPlugin(),
    )),
  ),

  ChangeNotifierProvider<SessionProvider>(
    create: (context) => SessionProvider(sessionRepository: context.read<SessionRepository>()),
  ),

  // Repositorio LogIn

  Provider<AuthenticationRepository>(
    create: (_) => AuthenticationRepositoryImpl(
      const FlutterSecureStorage(),
      AuthenticationService(Http(
        http.Client(),
        AppConstants.testUrl,
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
      authenticationRepository: context.read<AuthenticationRepository>(),
      fbm: FirebaseMessaging.instance,
      secureStorage: const FlutterSecureStorage(),
    ),
  ),

// -----------------------------------------------------------------------------
// CARGA DE DATOS DE USUARIO: Provider para cargar los datos del usuario
// -----------------------------------------------------------------------------

  ChangeNotifierProvider(
    create: (context) => UserSessionProvider(),
  ),

// -----------------------------------------------------------------------------
// CERRAR SESION: Provider y repositorio para cerrar sesion
// -----------------------------------------------------------------------------

  Provider<LogoutRepository>(
    create: (context) => LogoutRepositoryImpl(
        logoutService:
            LogoutService(http: Http(http.Client(), AppConstants.testUrl)),
        secureStorage: const FlutterSecureStorage()),
  ),

  ChangeNotifierProvider<LogoutProvider>(
    create: (context) =>
        LogoutProvider(logoutRepository: context.read<LogoutRepository>()),
  ),

//! =============================================

  Provider<HomeRepository>(
    create: (_) => HomeRepositoryImpl(
        HomeApi(Http(
          http.Client(),
          AppConstants.testUrl,
        )),
        const FlutterSecureStorage()),
  ),

  ChangeNotifierProvider.value(value: StartingPointController()),
  Provider<StartingPointRepository>(
    create: (_) => StartingPointImpl(
        StartingPointApi(Http(
          http.Client(),
          AppConstants.testUrl,
        )),
        const FlutterSecureStorage()),
  ),

// -----------------------------------------------------------------------------
// DETALLE DEL TICKET: Repositorio para cargar el detall del ticket
// -----------------------------------------------------------------------------

  Provider<DetailRepository>(
    create: (context) => DetailRepositoryImpl(
      detailService: DetailService(
        http: Http(http.Client(), AppConstants.testUrl),
      ),
    ),
  ),

  ChangeNotifierProvider<DetailProvider>(
    create: (context) =>
        DetailProvider(detailRepository: context.read<DetailRepository>()),
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
    create: (context) => AssignedToProvider(assignedToRepository: context.read<AssignedToRepository>()),
  ),

  //  Repositorio para verificar si el ticket esta agendado

  Provider<ScheduleForRepository>(
    create: (context) => ScheduleForRepositoryImpl(scheduleForService: ScheduleForService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<ScheduleForProvider>(
    create: (context) => ScheduleForProvider(scheduleForRepository: context.read<ScheduleForRepository>()),
  ),

  // Repositorio para verificar si el ticket tiene un costo asignado

  Provider<PrizedByRepository>(
    create: (context) => PrizedByRepositoryImpl(prizedByService: PrizedByService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<PrizedByProvider>(
    create: (context) => PrizedByProvider(prizedByRepository: context.read<PrizedByRepository>()),
  ),

  // Repositorio para verificar si el ticket ya fue suspendido minimo una vez

  Provider<SuspendedByRepository>(
    create: (context) => SuspendedByRepositoryImpl(suspendedByService: SuspendedByService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<SuspendedByProvider>(
    create: (context) => SuspendedByProvider(suspendedByRepository: context.read<SuspendedByRepository>()),
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
    create: (context) => SupplierProvider(supplierRepository: context.read<SupplierRepository>()),
  ),

  // Repositorio para cargar las sucursales en el detalle del ticket

  Provider<BranchofficeRepository>(
    create: (context) => BranchofficeRepositoryImpl(branchofficeService: BranchofficeService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<BranchofficeProvider>(
    create: (context) => BranchofficeProvider(branchofficeRepository: context.read<BranchofficeRepository>()),
  ),

  // Repositorio para cargar los supervisores en el detalle del ticket

  Provider<SupervisorRepository>(
    create: (context) => SupervisorRepositoryImpl(supervisorService: SupervisorService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<SupervisorProvider>(
    create: (context) => SupervisorProvider(supervisorRepository: context.read<SupervisorRepository>()),
  ),

  // Repositorio para asignar el ticket

  Provider<AssignRepository>(
    create: (context) => AssignRepositoryImpl(assignService: AssignService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<AssignProvider>(
    create: (context) => AssignProvider(assignRepository: context.read<AssignRepository>()),
  ),

  // Repositorio para agregar un mensaje al ticket

  Provider<AddMessageRepository>(
    create: (context) => AddMessageRepositoryImpl(addMessageService: AddMessageService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<AddMessageProvider>(
    create: (context) => AddMessageProvider(addMessageRepository: context.read<AddMessageRepository>()),
  ),

  // Repositorio para cargar mensajes de seguimiento

  Provider<TrackingRepository>(
    create: (context) => TrackingRepositoryImpl(trackingService: TrackingService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<TrackingProvider>(
    create: (context) => TrackingProvider(trackingRepository: context.read<TrackingRepository>()),
  ),

  // Repositorio para agendar un ticket

  Provider<ScheduleRepository>(
    create: (context) => ScheduleRepositoryImpl(scheduleService: ScheduleService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<ScheduleProvider>(
    create: (context) => ScheduleProvider(scheduleRepository: context.read<ScheduleRepository>()),
  ),

  // Repositorio para cotizar un ticket
  Provider<PriceRepository>(
    create: (context) => PriceRepositoryImpl(priceService: PriceService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<PriceProvider>(
    create: (context) => PriceProvider(priceRepository: context.read<PriceRepository>()),
  ),

  // Repositorio para suspender un ticket

  Provider<SuspendRepository>(
    create: (context) => SuspendRepositoryImpl(suspendService: SuspendService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<SuspendProvider>(
    create: (context) => SuspendProvider(suspendRepository: context.read<SuspendRepository>()),
  ),

  // Repositorio para activar un ticket

  Provider<ActivateRepository>(
    create: (context) => ActivateRepositoryImpl(activateService: ActivateService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<ActivateProvider>(
    create: (context) => ActivateProvider(activateRepository: context.read<ActivateRepository>()),
  ),

  // Repositorio para cancelar un ticket

  Provider<CancelRepository>(
    create: (context) => CancelRepositoryImpl(cancelService: CancelService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<CancelProvider>(
    create: (context) => CancelProvider(cancelRepository: context.read<CancelRepository>()),
  ),

  // Repositorio para realizar un ticket

  Provider<DoneRepositroy>(
    create: (context) => DoneRepositoryImpl(doneService: DoneService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<DoneProvider>(
    create: (context) => DoneProvider(doneRepositroy: context.read<DoneRepositroy>()),
  ),

  // Repositorio para aprobar un ticket

  Provider<ApproveRepository>(
    create: (context) => ApproveRepositoryImpl(approveService: ApproveService(http: Http(http.Client(), AppConstants.baseUrl))),
  ),

  ChangeNotifierProvider<ApproveProvider>(
    create: (context) => ApproveProvider(approveRepository: context.read<ApproveRepository>()),
  ),
];
