import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/dialogs/schedule_ticket_dialog.dart';

import '../../colors.dart';
import '../dialogs/assign_supervisor_dialog.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  final int fkMaintenance;
  final String assignStatus;
  final String scheduleStatus;

  const SpeedDialDetailTicket({
    super.key,
    required this.fkMaintenance,
    required this.assignStatus,
    required this.scheduleStatus,
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabledAssignSpeedChild = assignStatus == 'Asignado';
    bool isDisabledScheduleSpeedChild = scheduleStatus == 'Agendado';

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
