import 'package:flutter/material.dart';

import '../../../data/models/maintenances_model.dart';
import '../../../data/models/ticket_card_model.dart';
import '../../global/colors.dart';
import '../../global/widgets/texts/general_text.dart';
import 'package:mantiz/src/presentation/pages/home_redesign/home_redesign_vm.dart';

import 'package:provider/provider.dart';

class HomeRedesignView extends StatefulWidget {
  const HomeRedesignView({super.key});

  @override
  State<HomeRedesignView> createState() => _HomeRedesignViewState();
}

class _HomeRedesignViewState extends State<HomeRedesignView> {
  @override
  void initState() {
    super.initState();

    final vmInit = Provider.of<HomeRedesignVm>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.initProcess();

      vmInit.loadMaintenances(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeRedesignVm>(context);

    final bool isToday = vm.selectedDate.day == DateTime.now().day && vm.selectedDate.month == DateTime.now().month && vm.selectedDate.year == DateTime.now().year;

    return Scaffold(
      backgroundColor: sidonSecondaryColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 The calendar is fixed at the top of the screen ...
          _buildWeekCalendar(vm),

          // 🔥 Scrollable content goes inside expanded ...
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await vm.loadMaintenances(context);
              },
              child: isToday
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        vm.isLoading ? const Center(child: CircularProgressIndicator()) : _buildTodaySection(vm),
                        if (!vm.isLoading) _buildTomorrowSection(vm),
                        if (!vm.isLoading) _buildUpcomingSection(vm),
                        const SizedBox(height: 20),
                      ],
                    )
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        _buildFilterByDaySection(vm),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFAB(),
    );
  }

  // APPBAR
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: sidonPrimaryColor,
      elevation: 0,
      title: const GeneralText(
        mensaje: 'Home',
        maxLines: 1,
        overFlow: TextOverflow.ellipsis,
        size: 20,
        weight: FontWeight.bold,
        color: whiteGlobalColor,
        align: TextAlign.start,
      ),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.home, color: whiteGlobalColor),
        onPressed: () {},
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: whiteGlobalColor),
              onPressed: () {},
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: redPrincipal,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: sidonPrimaryColor, size: 18),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // WEEK CALENDAR
  Widget _buildWeekCalendar(HomeRedesignVm vm) {
    return Container(
      color: whiteGlobalColor,
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 10),
              GeneralText(
                mensaje: vm.monthYear,
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                size: 18,
                weight: FontWeight.bold,
                color: sidonBackgroundDarkColor,
                align: TextAlign.start,
              ),
              Expanded(child: Container()),
              GeneralText(
                mensaje: 'Week ${vm.weekNumber}',
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                size: 16,
                weight: FontWeight.bold,
                color: sidonPrimaryColor,
                align: TextAlign.start,
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 16),

          // Navegación y días de la semana
          Row(
            children: [
              // Botón anterior
              GestureDetector(
                  onTap: () async {
                    await vm.addSubstractWeek('substract');
                  },
                  child: const SizedBox(
                    height: 40,
                    width: 20,
                    child: Icon(Icons.chevron_left, color: sidonPrimaryColor),
                  )),

              // Días de la semana
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 1.5,
                    children: List.generate(
                      vm.weekDays.length,
                      (index) {
                        final dayDate = vm.daysOfWeek[index];
                        final today = DateTime.now();
                        final isToday = dayDate.day == today.day && dayDate.month == today.month && dayDate.year == today.year;
                        final isSelected = dayDate.day == vm.selectedDate.day && dayDate.month == vm.selectedDate.month && dayDate.year == vm.selectedDate.year;

                        return GestureDetector(
                          onTap: () async {
                            await vm.selectDay(dayDate);

                            await vm.filterByDaySelected();
                          },
                          child: Container(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              color: isToday
                                  ? Colors.amber[700]
                                  : isSelected
                                      ? sidonTextColor
                                      : sidonSecondaryColor,
                              borderRadius: BorderRadius.circular(14),
                              border: isToday ? Border.all(color: Colors.amber[100]!, width: 2) : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GeneralText(
                                  mensaje: vm.weekDays[index],
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 11,
                                  weight: FontWeight.w500,
                                  color: isToday || isSelected ? whiteGlobalColor : sidonBackgroundDarkColor,
                                  align: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                GeneralText(
                                  mensaje: dayDate.day.toString(),
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 16,
                                  weight: FontWeight.bold,
                                  color: isToday || isSelected ? whiteGlobalColor : sidonBackgroundDarkColor,
                                  align: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Botón siguiente
              GestureDetector(
                  onTap: () async {
                    await vm.addSubstractWeek('add');
                  },
                  child: const SizedBox(
                    height: 40,
                    width: 25,
                    child: Icon(Icons.chevron_right, color: sidonPrimaryColor),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  // Construcción de filter by day section ...
  Widget _buildFilterByDaySection(HomeRedesignVm vm) {
    List<MaintenancesModel> lstByDay = vm.filterByDayMaintenances;

    if (lstByDay.isNotEmpty) {
      TaskCardData? taskByDay;
      List<TicketCardModel> tasks = [];

      for (var m in lstByDay) {
        if (m.branchoffices.isNotEmpty) {
          for (var bo in m.branchoffices) {
            if (bo.tickets.isNotEmpty) {
              for (var t in bo.tickets) {
                TicketCardModel cardByDay = TicketCardModel(
                  idCustomer: m.id,
                  customer: m.customer,
                  idBO: bo.boId,
                  branchofficeId: bo.branchofficeId,
                  branchOffice: bo.branchoffice,
                  address: bo.address,
                  latitude: bo.latitude,
                  longitude: bo.longitude,
                  clave: bo.clave,
                  ticket: t,
                );

                tasks.add(cardByDay);
              }
            } else {
              return _viewerListByDay(null, vm);
            }
          }
        } else {
          return _viewerListByDay(null, vm);
        }
      }

      taskByDay = TaskCardData(countItems: tasks.length, tasks: tasks);

      return _viewerListByDay(taskByDay, vm);
    } else {
      return _viewerListByDay(null, vm);
    }
  }

  // Constrution of Today section ...
  Widget _buildTodaySection(HomeRedesignVm vm) {
    List<MaintenancesModel> lstToday = vm.todayMaintenances;

    if (lstToday.isNotEmpty) {
      TaskCardData? taskToday;
      List<TicketCardModel> tasks = [];

      for (var m in lstToday) {
        if (m.branchoffices.isNotEmpty) {
          for (var bo in m.branchoffices) {
            if (bo.tickets.isNotEmpty) {
              for (var t in bo.tickets) {
                TicketCardModel cardToday = TicketCardModel(
                  idCustomer: m.id,
                  customer: m.customer,
                  idBO: bo.boId,
                  branchofficeId: bo.branchofficeId,
                  branchOffice: bo.branchoffice,
                  address: bo.address,
                  latitude: bo.latitude,
                  longitude: bo.longitude,
                  clave: bo.clave,
                  ticket: t,
                );

                tasks.add(cardToday);
              }
            } else {
              return _viewerListToday(null, vm);
            }
          }
        } else {
          return _viewerListToday(null, vm);
        }
      }

      taskToday = TaskCardData(countItems: tasks.length, tasks: tasks);

      return _viewerListToday(taskToday, vm);
    } else {
      return _viewerListToday(null, vm);
    }
  }

  // Constrution of Tomorrow section ...
  Widget _buildTomorrowSection(HomeRedesignVm vm) {
    List<MaintenancesModel> lstTomorrow = vm.tomorrowMaintenances;

    if (lstTomorrow.isNotEmpty) {
      TaskCardData? taskTomorrow;
      List<TicketCardModel> tasks = [];

      for (var m in lstTomorrow) {
        if (m.branchoffices.isNotEmpty) {
          for (var bo in m.branchoffices) {
            if (bo.tickets.isNotEmpty) {
              for (var t in bo.tickets) {
                TicketCardModel cardTomorrow = TicketCardModel(
                  idCustomer: m.id,
                  customer: m.customer,
                  idBO: bo.boId,
                  branchofficeId: bo.branchofficeId,
                  branchOffice: bo.branchoffice,
                  address: bo.address,
                  latitude: bo.latitude,
                  longitude: bo.longitude,
                  clave: bo.clave,
                  ticket: t,
                );

                tasks.add(cardTomorrow);
              }
            } else {
              return _viewerListTomorrow(null, vm);
            }
          }
        } else {
          return _viewerListTomorrow(null, vm);
        }
      }

      taskTomorrow = TaskCardData(countItems: tasks.length, tasks: tasks);

      return _viewerListTomorrow(taskTomorrow, vm);
    } else {
      return _viewerListTomorrow(null, vm);
    }
  }

  // Constrution of Upcoming section ...
  Widget _buildUpcomingSection(HomeRedesignVm vm) {
    List<MaintenancesModel> lstUpcoming = vm.upcomingMaintenances;

    if (lstUpcoming.isNotEmpty) {
      TaskCardData? taskUpcoming;
      List<TicketCardModel> tasks = [];

      for (var m in lstUpcoming) {
        if (m.branchoffices.isNotEmpty) {
          for (var bo in m.branchoffices) {
            if (bo.tickets.isNotEmpty) {
              for (var t in bo.tickets) {
                TicketCardModel cardUpcoming = TicketCardModel(
                  idCustomer: m.id,
                  customer: m.customer,
                  idBO: bo.boId,
                  branchofficeId: bo.branchofficeId,
                  branchOffice: bo.branchoffice,
                  address: bo.address,
                  latitude: bo.latitude,
                  longitude: bo.longitude,
                  clave: bo.clave,
                  ticket: t,
                );

                tasks.add(cardUpcoming);
              }
            } else {
              return _viewerListUpcoming(null, vm);
            }
          }
        } else {
          return _viewerListUpcoming(null, vm);
        }
      }

      taskUpcoming = TaskCardData(countItems: tasks.length, tasks: tasks);

      return _viewerListUpcoming(taskUpcoming, vm);
    } else {
      return _viewerListUpcoming(null, vm);
    }
  }

  // ListViewer to show ...
  Widget _viewerListByDay(TaskCardData? task, HomeRedesignVm vm) {
    return (task != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: List.generate(
                task.tasks.length,
                (index) => _cardToAllLists(task.tasks[index]),
              ),
            ),
          )
        : Container();
  }

  Widget _viewerListToday(TaskCardData? task, HomeRedesignVm vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Hoy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: sidonBackgroundDarkColor,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task != null ? '${task.countItems} TASKS' : '0 TASKS',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: sidonBackgroundDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
              (task == null)
                  ? Container()
                  : IconButton(
                      onPressed: () async {
                        await vm.toggleCollapse('today');
                      },
                      icon: Icon(
                        vm.todayIsCollapsed ? Icons.expand_more : Icons.expand_less,
                        color: sidonBackgroundDarkColor,
                      )),
            ],
          ),
          const SizedBox(height: 12),
          (task != null && !vm.todayIsCollapsed)
              ? Column(
                  children: List.generate(
                    task.tasks.length,
                    (index) => _cardToAllLists(task.tasks[index]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _viewerListTomorrow(TaskCardData? task, HomeRedesignVm vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Mañana',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: sidonBackgroundDarkColor,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task != null ? '${task.countItems} TASKS' : '0 TASKS',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: sidonBackgroundDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
              (task == null)
                  ? Container()
                  : IconButton(
                      onPressed: () async {
                        await vm.toggleCollapse('tomorrow');
                      },
                      icon: Icon(
                        vm.tomorrowIsCollapsed ? Icons.expand_more : Icons.expand_less,
                        color: sidonBackgroundDarkColor,
                      )),
            ],
          ),
          const SizedBox(height: 12),
          (task != null && !vm.tomorrowIsCollapsed)
              ? Column(
                  children: List.generate(
                    task.tasks.length,
                    (index) => _cardToAllLists(task.tasks[index]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _viewerListUpcoming(TaskCardData? task, HomeRedesignVm vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Próximas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: sidonBackgroundDarkColor,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: lightGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task != null ? '${task.countItems} TASKS' : '0 TASKS',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: sidonBackgroundDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
              (task == null)
                  ? Container()
                  : IconButton(
                      onPressed: () async {
                        await vm.toggleCollapse('tomorrow');
                      },
                      icon: Icon(
                        vm.tomorrowIsCollapsed ? Icons.expand_more : Icons.expand_less,
                        color: sidonBackgroundDarkColor,
                      )),
            ],
          ),
          const SizedBox(height: 12),
          (task != null && !vm.tomorrowIsCollapsed)
              ? Column(
                  children: List.generate(
                    task.tasks.length,
                    (index) => _cardToAllLists(task.tasks[index]),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  // Card to show in all lists ...
  Widget _cardToAllLists(TicketCardModel ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteGlobalColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: sidonBackgroundDarkColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: const Border(
          left: BorderSide(
            color: sidonPrimaryColor,
            width: 4,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GeneralText(
                mensaje: '${ticket.ticket.showFolio} - ${ticket.ticket.createdat}',
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                size: 13,
                weight: FontWeight.bold,
                color: sidonBackgroundDarkColor,
                align: TextAlign.start,
              ),
              const SizedBox(height: 5),
              GeneralText(
                mensaje: ticket.ticket.title ?? '',
                maxLines: 2,
                overFlow: TextOverflow.ellipsis,
                size: 16,
                weight: FontWeight.normal,
                color: sidonBackgroundDarkColor,
                align: TextAlign.start,
              ),
              const SizedBox(height: 5),
              GeneralText(
                mensaje: ticket.ticket.area,
                maxLines: 2,
                overFlow: TextOverflow.ellipsis,
                size: 13,
                weight: FontWeight.bold,
                color: sidonBackgroundDarkColor,
                align: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: (ticket.ticket.status.toLowerCase() == 'actualizado' ||
                            ticket.ticket.status.toLowerCase() == 'abierto' ||
                            ticket.ticket.status.toLowerCase() == 'asignado' ||
                            ticket.ticket.status.toLowerCase() == 'aprobado' ||
                            ticket.ticket.status.toLowerCase() == 'agendado')
                        ? blueSuperLightColor
                        : (ticket.ticket.status.toLowerCase() == 'suspendido' ||
                                ticket.ticket.status.toLowerCase() == 'cancelado' ||
                                ticket.ticket.status.toLowerCase() == 'rechazado')
                            ? palePink
                            : (ticket.ticket.status.toLowerCase() == 'rechazado' || ticket.ticket.status.toLowerCase() == 'creado')
                                ? softYellow
                                : (ticket.ticket.status.toLowerCase() == 'finalizado')
                                    ? mintGreen
                                    : ultraLightGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GeneralText(
                      mensaje: ticket.ticket.status,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: (ticket.ticket.status.toLowerCase() == 'actualizado' ||
                              ticket.ticket.status.toLowerCase() == 'abierto' ||
                              ticket.ticket.status.toLowerCase() == 'asignado' ||
                              ticket.ticket.status.toLowerCase() == 'aprobado' ||
                              ticket.ticket.status.toLowerCase() == 'agendado')
                          ? orangePrincipal
                          : (ticket.ticket.status.toLowerCase() == 'suspendido' ||
                                  ticket.ticket.status.toLowerCase() == 'cancelado' ||
                                  ticket.ticket.status.toLowerCase() == 'rechazado')
                              ? redPrincipal
                              : (ticket.ticket.status.toLowerCase() == 'rechazado' || ticket.ticket.status.toLowerCase() == 'creado')
                                  ? blueLightGlobalColor
                                  : (ticket.ticket.status.toLowerCase() == 'finalizado')
                                      ? greenPrincipal
                                      : blackPanter,
                      align: TextAlign.left),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: veryLightGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GeneralText(
                    mensaje: ticket.ticket.type,
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                    size: 14,
                    weight: FontWeight.bold,
                    color: mediumDarkGray,
                    align: TextAlign.left,
                  ),
                ),
                Expanded(child: Container()),
                TextButton.icon(
                  onPressed: () {
                    // Acción al presionar
                  },
                  icon: const Icon(Icons.arrow_forward, color: sidonPrimaryColor),
                  label: const Text(
                    'Detalle',
                    style: TextStyle(
                      color: sidonPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: sidonPrimaryColor),
                    ),
                    backgroundColor: whiteGlobalColor,
                  ),
                )
              ])
            ]),
          ),
        ]),
      ),
    );
  }

  // FAB
  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF1DE9B6),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.black87,
        size: 28,
      ),
    );
  }
}

// DATA MODEL
class TaskCardData {
  final int countItems;
  List<TicketCardModel> tasks;

  TaskCardData({
    required this.countItems,
    required this.tasks,
  });
}
