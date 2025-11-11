import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/dialogs/approve_ticket_dialog.dart';

import '../../colors.dart';
import '../dialogs/done_ticket_dialog.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  final int ticketId;
  final int userId;
  final String status;

  const SpeedDialDetailTicket({
    super.key,
    required this.ticketId,
    required this.userId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
// SPEEDDIALCHILDREN: Cotizacion
// -----------------------------------------------------------------------------

    // final approveSpeedDialChildren = <SpeedDialChild>[
    //   SpeedDialChild(
    //     child: const Icon(Icons.attach_money_rounded),
    //     backgroundColor: darkGray,
    //     foregroundColor: veryLightGray,
    //     label: 'Cotización',
    //     onTap: () async {
    //       const storage = FlutterSecureStorage();
    //       String? fkPartnerLicence =
    //           await storage.read(key: 'fkPartnerLicence');
    //       showDialog(
    //         // ignore: use_build_context_synchronously
    //         context: context,
    //         builder: (context) {
    //           return PriceTicketDialog(
    //             fkMaintenance: fkMaintenance,
    //             createdByPartner: int.parse(fkPartnerLicence!),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // ];

    final doneSpeedDialChildren = <SpeedDialChild>[
      SpeedDialChild(
        child: const Icon(Icons.check),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Aprobar',
        onTap: () async {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return ApproveTicketDialog(
                fkMaintenance: ticketId,
                approveByPartner: userId,
              );
            },
          );
        },
      ),

// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: COTIZACION
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.attach_money_rounded),
      //   backgroundColor: darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Cotización',
      //   onTap: () async {
      //     const storage = FlutterSecureStorage();
      //     String? fkPartnerLicence =
      //         await storage.read(key: 'fkPartnerLicence');
      //     showDialog(
      //       // ignore: use_build_context_synchronously
      //       context: context,
      //       builder: (context) {
      //         return PriceTicketDialog(
      //           fkMaintenance: fkMaintenance,
      //           createdByPartner: int.parse(fkPartnerLicence!),
      //         );
      //       },
      //     );
      //   },
      // ),
    ];

// -----------------------------------------------------------------------------
// SPEEDDIALCHILDREN: Speedchild cuando un ticket esta suspendido
// -----------------------------------------------------------------------------

    // final suspendedSpeedDialChildren = <SpeedDialChild>[
    //   SpeedDialChild(
    //     child: const Icon(Icons.check_rounded),
    //     backgroundColor: darkGray,
    //     foregroundColor: veryLightGray,
    //     label: 'Activar',
    //     onTap: () async {
    //       const storage = FlutterSecureStorage();
    //       String? fkPartnerLicence =
    //           await storage.read(key: 'fkPartnerLicence');
    //       showDialog(
    //         // ignore: use_build_context_synchronously
    //         context: context,
    //         builder: (context) {
    //           return ActivateTicketDialog(
    //             fkMaintenance: fkMaintenance,
    //             openByPartner: int.parse(fkPartnerLicence!),
    //           );
    //         },
    //       );
    //     },
    //   ),
    //   SpeedDialChild(
    //     child: const Icon(Icons.cancel_outlined),
    //     backgroundColor: darkGray,
    //     foregroundColor: veryLightGray,
    //     label: 'Cancelar',
    //     onTap: () async {
    //       const storage = FlutterSecureStorage();
    //       String? fkPartnerLicence =
    //           await storage.read(key: 'fkPartnerLicence');
    //       showDialog(
    //         // ignore: use_build_context_synchronously
    //         context: context,
    //         builder: (context) {
    //           return CancelTicketDialog(
    //               fkMaintenance: fkMaintenance,
    //               cancelByPartner: int.parse(fkPartnerLicence!));
    //         },
    //       );
    //     },
    //   )
    // ];

    final allSpeedDialChildren = <SpeedDialChild>[
// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: Asignar supervisor
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.file_copy),
      //   backgroundColor: isDisabledAssignSpeedChild ? lightGray : darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Asignar Supervisor',
      //   onTap: isDisabledAssignSpeedChild
      //       ? () {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text('El ticket ya ha sido asignado.'),
      //             ),
      //           );
      //         }
      //       : () async {
      //           const storage = FlutterSecureStorage();
      //           String? fkPartnerLicence =
      //               await storage.read(key: 'fkPartnerLicence');
      //           final result = await showDialog(
      //             // ignore: use_build_context_synchronously
      //             context: context,
      //             builder: (context) {
      //               return AssignSupervisorDialog(
      //                 fkPartnerLicence: fkPartnerLicence ?? '',
      //                 fkMaintenance: fkMaintenance,
      //               );
      //             },
      //           );
      //           if (result == true) {
      //             final assignedProvider =
      //                 // ignore: use_build_context_synchronously
      //                 Provider.of<AssignedToProvider>(context, listen: false);
      //             await assignedProvider
      //                 .fetchAssignedTo(fkMaintenance.toString());
      //           }
      //         },
      // ),

// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: Agendar
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.calendar_month),
      //   backgroundColor: isDisabledScheduleSpeedChild ? lightGray : darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Agendar',
      //   onTap: isDisabledScheduleSpeedChild
      //       ? () {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text('El ticket ya ha sido agendado.'),
      //             ),
      //           );
      //         }
      //       : () async {
      //           const storage = FlutterSecureStorage();
      //           String? fkPartnerLicence =
      //               await storage.read(key: 'fkPartnerLicence');
      //           final result = await showDialog(
      //             // ignore: use_build_context_synchronously
      //             context: context,
      //             builder: (context) {
      //               return ScheduleTicketDialog(
      //                 fkMaintenance: fkMaintenance,
      //                 scheduleByPartner: int.parse(fkPartnerLicence!),
      //               );
      //             },
      //           );
      //           if (result == true) {
      //             final scheduledProvider =
      //                 // ignore: use_build_context_synchronously
      //                 Provider.of<ScheduleForProvider>(context, listen: false);
      //             await scheduledProvider.fetchScheduleFor(fkMaintenance);
      //           }
      //         },
      // ),

// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: Cotizacion
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.attach_money_rounded),
      //   backgroundColor: darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Cotización',
      //   onTap: () async {
      //     const storage = FlutterSecureStorage();
      //     String? fkPartnerLicence =
      //         await storage.read(key: 'fkPartnerLicence');
      //     final result = await showDialog(
      //       // ignore: use_build_context_synchronously
      //       context: context,
      //       builder: (context) {
      //         return PriceTicketDialog(
      //           fkMaintenance: fkMaintenance,
      //           createdByPartner: int.parse(fkPartnerLicence!),
      //         );
      //       },
      //     );

      //     if (result == true) {
      //       final prizedProvider =
      //           // ignore: use_build_context_synchronously
      //           Provider.of<PrizedByProvider>(context, listen: false);
      //       await prizedProvider.fetchPrizedBy(fkMaintenance);
      //     }
      //   },
      // ),

// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: Suspender
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.pause_rounded),
      //   backgroundColor: isDisabledSuspendSpeedChild ? lightGray : darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Suspender',
      //   onTap: isDisabledSuspendSpeedChild
      //       ? () {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text('El ticket ya ha sido suspendido una vez.'),
      //             ),
      //           );
      //         }
      //       : () async {
      //           const storage = FlutterSecureStorage();
      //           String? fkPartnerLicence =
      //               await storage.read(key: 'fkPartnerLicence');
      //           showDialog(
      //             // ignore: use_build_context_synchronously
      //             context: context,
      //             builder: (context) {
      //               return SuspendTicketDialog(
      //                 fkMaintenance: fkMaintenance,
      //                 suspenderByPartner: int.parse(
      //                   fkPartnerLicence!,
      //                 ),
      //               );
      //             },
      //           );
      //           if (result == true) {
      //             final suspendedProvider =
      //                 // ignore: use_build_context_synchronously
      //                 Provider.of<SuspendedByProvider>(context, listen: false);
      //             await suspendedProvider.fetchSuspendedBy(fkMaintenance);
      //           }
      //         },
      // ),

// -----------------------------------------------------------------------------
// SPEEDDIALCHILD: Cancelar
// -----------------------------------------------------------------------------

      // SpeedDialChild(
      //   child: const Icon(Icons.cancel_outlined),
      //   backgroundColor: darkGray,
      //   foregroundColor: veryLightGray,
      //   label: 'Cancelar',
      //   onTap: () async {
      //     const storage = FlutterSecureStorage();
      //     String? fkPartnerLicence =
      //         await storage.read(key: 'fkPartnerLicence');
      //     showDialog(
      //       // ignore: use_build_context_synchronously
      //       context: context,
      //       builder: (context) {
      //         return CancelTicketDialog(
      //             fkMaintenance: fkMaintenance,
      //             cancelByPartner: int.parse(fkPartnerLicence!));
      //       },
      //     );
      //   },
      // ),
      SpeedDialChild(
        child: const Icon(Icons.done_rounded),
        backgroundColor: darkGray,
        foregroundColor: veryLightGray,
        label: 'Realizado',
        onTap: () async {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return DoneTicketDialog(
                fkMaintenance: ticketId,
                doneByPartner: userId,
              );
            },
          );
        },
      ),
    ];

    List<SpeedDialChild> childrenToShow;
    if (status == 'Finalizado') {
      childrenToShow = doneSpeedDialChildren;
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
