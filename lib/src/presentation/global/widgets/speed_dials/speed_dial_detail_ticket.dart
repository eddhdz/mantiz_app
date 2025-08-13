import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../colors.dart';
import '../dialogs/assign_supervisor_dialog.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  final int fkMaintenance;

  const SpeedDialDetailTicket({
    super.key,
    required this.fkMaintenance,
  });

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: mediumDarkGray,
          foregroundColor: veryLightGray,
          label: 'Asignar Supervisor',
          onTap: () async {
            final storage = FlutterSecureStorage();
            String? fkPartnerLicence =
                await storage.read(key: 'fkPartnerLicence');
            showDialog(
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
      ],
    );
  }
}
