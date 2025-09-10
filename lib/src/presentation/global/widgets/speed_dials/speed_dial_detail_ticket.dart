import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/prized_by_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_for_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/suspended_by_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/providers/ticket_detail/assigned_to_provider.dart';
import '../../colors.dart';
import '../dialogs/activate_ticket_dialog.dart';
import '../dialogs/assign_supervisor_dialog.dart';
import '../dialogs/cancel_ticket_dialog.dart';
import '../dialogs/done_ticket_dialog.dart';
import '../dialogs/price_ticket_dialog.dart';
import '../dialogs/schedule_ticket_dialog.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dialogs/suspend_ticket_dialog.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  final int fkMaintenance;
  final String assignStatus;
  final String scheduleStatus;
  final String generalStatus;
  final String suspendStatus;

  const SpeedDialDetailTicket({
    super.key,
    required this.fkMaintenance,
    required this.assignStatus,
    required this.scheduleStatus,
    required this.generalStatus,
    required this.suspendStatus,
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabledAssignSpeedChild = assignStatus == 'Asignado';
    bool isDisabledScheduleSpeedChild = scheduleStatus == 'Agendado';
    bool isDisabledSuspendSpeedChild = suspendStatus == 'Suspendido';

    final doneSpeedDialChildren = <SpeedDialChild>[
      SpeedDialChild(
        child: const Icon(Icons.check),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Aprobar',
        onTap: () {},
      ),
      SpeedDialChild(
        child: const Icon(Icons.attach_money_rounded),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Cotización',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return PriceTicketDialog(
                fkMaintenance: fkMaintenance,
                createdByPartner: int.parse(fkPartnerLicence!),
              );
            },
          );
        },
      ),
    ];

    final suspendedSpeedDialChildren = <SpeedDialChild>[
      SpeedDialChild(
        child: const Icon(Icons.check_rounded),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Activar',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return ActivateTicketDialog(
                fkMaintenance: fkMaintenance,
                openByPartner: int.parse(fkPartnerLicence!),
              );
            },
          );
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.cancel_outlined),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Cancelar',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return CancelTicketDialog(
                  fkMaintenance: fkMaintenance,
                  cancelByPartner: int.parse(fkPartnerLicence!));
            },
          );
        },
      )
    ];

    final allSpeedDialChildren = <SpeedDialChild>[
      SpeedDialChild(
        child: const Icon(Icons.file_copy),
        backgroundColor: isDisabledAssignSpeedChild ? lightGray : darkGray,
        foregroundColor: veryLightGray,
        label: 'Asignar Supervisor',
        onTap: isDisabledAssignSpeedChild
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El ticket ya ha sido asignado.'),
                  ),
                );
              }
            : () async {
                const storage = FlutterSecureStorage();
                String? fkPartnerLicence =
                    await storage.read(key: 'fkPartnerLicence');
                final result = await showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return AssignSupervisorDialog(
                      fkPartnerLicence: fkPartnerLicence ?? '',
                      fkMaintenance: fkMaintenance,
                    );
                  },
                );
                if (result == true) {
                  final assignedProvider =
                      // ignore: use_build_context_synchronously
                      Provider.of<AssignedToProvider>(context, listen: false);
                  await assignedProvider
                      .fetchAssignedTo(fkMaintenance.toString());
                }
              },
      ),
      SpeedDialChild(
        child: const Icon(Icons.calendar_month),
        backgroundColor: isDisabledScheduleSpeedChild ? lightGray : darkGray,
        foregroundColor: veryLightGray,
        label: 'Agendar',
        onTap: isDisabledScheduleSpeedChild
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El ticket ya ha sido agendado.'),
                  ),
                );
              }
            : () async {
                const storage = FlutterSecureStorage();
                String? fkPartnerLicence =
                    await storage.read(key: 'fkPartnerLicence');
                final result = await showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return ScheduleTicketDialog(
                      fkMaintenance: fkMaintenance,
                      scheduleByPartner: int.parse(fkPartnerLicence!),
                    );
                  },
                );
                if (result == true) {
                  final scheduledProvider =
                      // ignore: use_build_context_synchronously
                      Provider.of<ScheduleForProvider>(context, listen: false);
                  await scheduledProvider.fetchScheduleFor(fkMaintenance);
                }
              },
      ),
      SpeedDialChild(
        child: const Icon(Icons.attach_money_rounded),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Cotización',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          final result = await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return PriceTicketDialog(
                fkMaintenance: fkMaintenance,
                createdByPartner: int.parse(fkPartnerLicence!),
              );
            },
          );

          if (result == true) {
            final prizedProvider =
                // ignore: use_build_context_synchronously
                Provider.of<PrizedByProvider>(context, listen: false);
            await prizedProvider.fetchPrizedBy(fkMaintenance);
          }
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.pause_rounded),
        backgroundColor: isDisabledSuspendSpeedChild ? lightGray : darkGray,
        foregroundColor: veryLightGray,
        label: 'Suspender',
        onTap: isDisabledSuspendSpeedChild
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El ticket ya ha sido suspendido una vez.'),
                  ),
                );
              }
            : () async {
                const storage = FlutterSecureStorage();
                String? fkPartnerLicence =
                    await storage.read(key: 'fkPartnerLicence');
                showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return SuspendTicketDialog(
                      fkMaintenance: fkMaintenance,
                      suspenderByPartner: int.parse(
                        fkPartnerLicence!,
                      ),
                    );
                  },
                );
                // if (result == true) {
                //   final suspendedProvider =
                //       // ignore: use_build_context_synchronously
                //       Provider.of<SuspendedByProvider>(context, listen: false);
                //   await suspendedProvider.fetchSuspendedBy(fkMaintenance);
                // }
              },
      ),
      SpeedDialChild(
        child: const Icon(Icons.cancel_outlined),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Cancelar',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return CancelTicketDialog(
                  fkMaintenance: fkMaintenance,
                  cancelByPartner: int.parse(fkPartnerLicence!));
            },
          );
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.done_rounded),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Realizado',
        onTap: () async {
          const storage = FlutterSecureStorage();
          String? fkPartnerLicence =
              await storage.read(key: 'fkPartnerLicence');
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return DoneTicketDialog(
                fkMaintenance: fkMaintenance,
                doneByPartner: int.parse(fkPartnerLicence!),
              );
            },
          );
        },
      ),
    ];

    List<SpeedDialChild> childrenToShow;
    if (generalStatus == 'Finalizado') {
      childrenToShow = doneSpeedDialChildren;
    } else if (generalStatus == 'Suspendido') {
      childrenToShow = suspendedSpeedDialChildren;
    } else {
      childrenToShow = allSpeedDialChildren;
    }

    return SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: mediumGray,
        foregroundColor: lightGray,
        spacing: 10,
        childMargin: const EdgeInsets.symmetric(horizontal: 10),
        children: childrenToShow);
  }
}
