import 'package:flutter/material.dart';

import '../../colors.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../dialogs/assign_supervisor_dialog.dart';

class SpeedDialDetailTicket extends StatelessWidget {
  const SpeedDialDetailTicket({super.key});

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
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AssignSupervisorDialog(
                  fkPartnerLicence: '3',
                );
              },
            );
          },
        ),
      ],
    );
  }
}
