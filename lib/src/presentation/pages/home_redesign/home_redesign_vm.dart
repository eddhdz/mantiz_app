import 'package:flutter/material.dart';

import '../../../data/models/branch_office_model.dart';
import '../../../data/models/maintenances_model.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/home/home_repository.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class HomeRedesignVm with ChangeNotifier {
  final secure = const FlutterSecureStorage();

  // Propiedades de la clase ...
  List<MaintenancesModel> _allMaintenances = [];
  List<MaintenancesModel> get allMaintenances => _allMaintenances;

  List<MaintenancesModel> _todayMaintenances = [];
  List<MaintenancesModel> get todayMaintenances => _todayMaintenances;

  List<MaintenancesModel> _tomorrowMaintenances = [];
  List<MaintenancesModel> get tomorrowMaintenances => _tomorrowMaintenances;

  List<MaintenancesModel> _upcomingMaintenances = [];
  List<MaintenancesModel> get upcomingMaintenances => _upcomingMaintenances;

  List<MaintenancesModel> _filterByDayMaintenances = [];
  List<MaintenancesModel> get filterByDayMaintenances => _filterByDayMaintenances;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  DateTime _startOfWeek = DateTime.now();
  DateTime get startOfWeek => _startOfWeek;

  // DateTime _dayDate = DateTime.now();
  // DateTime get dayDate => _dayDate;

  List<DateTime> _daysOfWeek = [];
  List<DateTime> get daysOfWeek => _daysOfWeek;

  String _monthYear = '';
  String get monthYear => _monthYear;

  String? _typeUser = '';
  String? get typeUser => _typeUser;

  String? _typeRole = '';
  String? get typeRole => _typeRole;

  List<String> _weekDays = [];
  List<String> get weekDays => _weekDays;

  int _dayOfWeek = 0;
  int get dayOfWeek => _dayOfWeek;

  int _weekNumber = 0;
  int get weekNumber => _weekNumber;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _todayIsCollapsed = true;
  bool get todayIsCollapsed => _todayIsCollapsed;

  bool _tomorrowIsCollapsed = true;
  bool get tomorrowIsCollapsed => _tomorrowIsCollapsed;

  bool _upcomingIsCollapsed = true;
  bool get upcomingIsCollapsed => _upcomingIsCollapsed;

  // Métodos auxiliares ...
  String _getMonthYearString(DateTime date) {
    final months = ['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DECIEMBRE'];
    return '${months[date.month - 1]} ${date.year}';
  }

  int _getWeekNumber(DateTime date) {
    final jan4 = DateTime(date.year, 1, 4);
    final dayDifference = date.difference(jan4).inDays;
    return (dayDifference / 7).floor() + 1;
  }

  // Cambio de estado de colapso ...
  Future<void> toggleCollapse(String flag) async {
    if (flag.toLowerCase() == 'today') {
      _todayIsCollapsed = !_todayIsCollapsed;
    } else if (flag.toLowerCase() == 'tomorrow') {
      _tomorrowIsCollapsed = !_tomorrowIsCollapsed;
    } else if (flag.toLowerCase() == 'upcoming') {
      _upcomingIsCollapsed = !_upcomingIsCollapsed;
    } else {
      return;
    }

    notifyListeners();
  }

  // Cargado de listas ...
  Future<void> loadMaintenances(BuildContext context) async {
    _isLoading = true;
    _allMaintenances = [];
    _todayMaintenances = [];
    _tomorrowMaintenances = [];
    _upcomingMaintenances = [];

    notifyListeners();

    final result = await Provider.of<HomeRepository>(context, listen: false).loadMaintenances();

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'No records found',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (maintenances) {
      _allMaintenances = maintenances;

      bool mismaFecha(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

      // Filtrar mantenimientos por fecha ...
      final today = DateTime.now();
      final tomorrow = today.add(const Duration(days: 1));

      _todayMaintenances = filterStructure(
        _allMaintenances,
        (fecha) => mismaFecha(fecha, today),
      );

      _tomorrowMaintenances = filterStructure(
        _allMaintenances,
        (fecha) => mismaFecha(fecha, tomorrow),
      );

      _upcomingMaintenances = filterStructure(
        _allMaintenances,
        (fecha) => !mismaFecha(fecha, today) && !mismaFecha(fecha, tomorrow),
      );
    });

    _isLoading = false;
    notifyListeners();
  }

  // Metodo de inicialización ...
  Future<void> initProcess() async {
    _selectedDate = DateTime.now();

    _weekDays = ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];

    // Calcular el inicio de la semana (lunes) basado en _selectedDate
    _dayOfWeek = _selectedDate.weekday; // 1 = Lunes, 7 = Dommingo
    _startOfWeek = _selectedDate.subtract(Duration(days: dayOfWeek - 1));

    // Obtener los días de la semana
    _daysOfWeek = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    // Obtener mes y año
    _monthYear = _getMonthYearString(startOfWeek);
    _weekNumber = _getWeekNumber(startOfWeek);

    notifyListeners();
  }

  Future<void> chargeTypesForUser() async {
    _typeUser = await secure.read(key: 'typeuser');
    _typeRole = await secure.read(key: 'typerol');

    notifyListeners();
  }

  // Método para avanzar o retreoceder semanas ...
  Future<void> addSubstractWeek(String flag) async {
    if (flag.toLowerCase() == 'add') {
      _selectedDate = _selectedDate.add(const Duration(days: 7));
    } else if (flag.toLowerCase() == 'substract') {
      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
    }

    // Calcular el inicio de la semana (lunes) basado en _selectedDate
    _dayOfWeek = _selectedDate.weekday; // 1 = Lunes, 7 = Dommingo
    _startOfWeek = _selectedDate.subtract(Duration(days: dayOfWeek - 1));

    // Obtener los días de la semana
    _daysOfWeek = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    // Obtener mes y año
    _monthYear = _getMonthYearString(startOfWeek);
    _weekNumber = _getWeekNumber(startOfWeek);

    notifyListeners();
  }

  // Método seleccionar día ...
  Future<void> selectDay(DateTime dayDate) async {
    _selectedDate = dayDate;
    notifyListeners();
  }

  // Método convertir String a Datetime ...
  DateTime parseFecha(String fecha) {
    final partes = fecha.split('-');

    final dia = int.parse(partes[0]);
    final mes = int.parse(partes[1]);
    final anio = int.parse(partes[2]);

    return DateTime(anio, mes, dia);
  }

  // Método para filtrar la estructura por día seleccionado ...
  Future<void> filterByDaySelected() async {
    _filterByDayMaintenances = [];
    bool mismaFecha(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

    // Filtrar mantenimientos por fecha ...
    final date = _selectedDate;

    _filterByDayMaintenances = filterStructure(
      _allMaintenances,
      (fecha) => mismaFecha(fecha, date),
    );

    notifyListeners();
  }

  // Método para filtrar la estructura de mantenimientos ...
  List<MaintenancesModel> filterStructure(
    List<MaintenancesModel> original,
    bool Function(DateTime fecha) filtro,
  ) {
    return original
        .map((mantenimiento) {
          final branchFiltradas = mantenimiento.branchoffices
              .map((branch) {
                final ticketsFiltrados = branch.tickets.where((ticket) {
                  final fecha = parseFecha(ticket.createdat);
                  return filtro(fecha);
                }).toList();

                return BranchOfficeModel(
                    boId: branch.boId,
                    branchofficeId: branch.branchofficeId,
                    branchoffice: branch.branchoffice,
                    address: branch.address,
                    latitude: branch.latitude,
                    longitude: branch.longitude,
                    clave: branch.clave,
                    tickets: ticketsFiltrados,
                    zones: branch.zones);
              })
              .where((branch) => branch.tickets.isNotEmpty)
              .toList();

          return MaintenancesModel(id: mantenimiento.id, customer: mantenimiento.customer, branchoffices: branchFiltradas);
        })
        .where((m) => m.branchoffices.isNotEmpty)
        .toList();
  }
}
