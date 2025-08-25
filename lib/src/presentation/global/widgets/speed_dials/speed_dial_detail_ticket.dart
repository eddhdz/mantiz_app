import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/dialogs/schedule_ticket_dialog.dart';

import '../../colors.dart';
import '../dialogs/assign_supervisor_dialog.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  final int fkMaintenance;
  final String status;

  const SpeedDialDetailTicket({
    super.key,
    required this.fkMaintenance,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabledSpeedChild = status == 'Asignado';
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      backgroundColor: mediumGray,
      foregroundColor: lightGray,
      spacing: 10,
      childMargin: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.file_copy),
          backgroundColor: isDisabledSpeedChild ? lightGray : darkGray,
          foregroundColor: veryLightGray,
          label: 'Asignar Supervisor',
          onTap: isDisabledSpeedChild
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
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return AssignSupervisorDialog(
                        fkPartnerLicence: fkPartnerLicence ?? '',
                        fkMaintenance: fkMaintenance,
                      );
                    },
                  );
                },
        ),
        SpeedDialChild(
          child: const Icon(Icons.calendar_month),
          backgroundColor: isDisabledSpeedChild ? lightGray : darkGray,
          foregroundColor: veryLightGray,
          label: 'Agendar',
          onTap: isDisabledSpeedChild
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
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return ScheduleTicketDialog(
                        fkMaintenance: fkMaintenance,
                        scheduleByPartner: int.parse(fkPartnerLicence!),
                      );
                    },
                  );
                },
        )
      ],
    );
  }
}
