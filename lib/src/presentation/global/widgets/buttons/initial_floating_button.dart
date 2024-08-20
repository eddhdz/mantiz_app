//! flutter ...
import 'package:flutter/material.dart';

//! imports locales ...
import '../../colors.dart';

//! paquetes implementados ...
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class InitialFloatingButton extends StatelessWidget {
  const InitialFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.keyboard_control,
      iconTheme: const IconThemeData(color: blackPanter),
      backgroundColor: lockWidget,
      spaceBetweenChildren: 5,
      closeManually: true,
      children: [
        SpeedDialChild(
            backgroundColor: blueNeutralGlobalColor,
            child: const Icon(
              Icons.account_circle,
              color: blackPanter,
            ),
            label: 'Perfil de Usuario',
            onTap: () async {
              print('Aqui toy!!!');
            }),
        SpeedDialChild(
            backgroundColor: blueNeutralGlobalColor,
            child: const Icon(
              Icons.add,
              color: blackPanter,
            ),
            label: 'Añadir ticket',
            onTap: () async {
              print('Aqui toy!!!');
            }),
        SpeedDialChild(
            backgroundColor: blueNeutralGlobalColor,
            child: const Icon(
              Icons.power_settings_new_rounded,
              color: blackPanter,
            ),
            label: 'Salir',
            onTap: () async {
              print('Aqui tañien!!!');
            }),
      ],
    );
  }
}
