//! flutter ...
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! imports locales ...
import '../../../../domain/enums.dart';
import '../../../../domain/providers/session/logout_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

//! paquetes implementados ...
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class InitialFloatingButton extends StatelessWidget {
  const InitialFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutProvider = Provider.of<LogoutProvider>(context, listen: false);
    return SpeedDial(
      icon: Icons.keyboard_control,
      iconTheme: const IconThemeData(color: blackPanter),
      backgroundColor: lockWidget,
      spaceBetweenChildren: 5,
      closeManually: false,
      children: [
        // SpeedDialChild(
        //     backgroundColor: mediumGray,
        //     child: const Icon(
        //       Icons.account_circle,
        //       color: blackPanter,
        //     ),
        //     label: 'Perfil de Usuario',
        //     onTap: () async {}),
        SpeedDialChild(
            backgroundColor: mediumGray,
            child: const Icon(
              Icons.add,
              color: blackPanter,
            ),
            label: 'Añadir ticket',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.newTicket);
            }),
        SpeedDialChild(
            backgroundColor: mediumGray,
            child: const Icon(
              Icons.power_settings_new_rounded,
              color: blackPanter,
            ),
            label: 'Salir',
            onTap: () async {
              await logoutProvider.fetchLogOut();
              if (logoutProvider.status == DataStatus.success) {
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      Routes.logIn,
                      (route) => false);
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al cerrar sesión.')));
                }
              }
            }),
      ],
    );
  }
}
