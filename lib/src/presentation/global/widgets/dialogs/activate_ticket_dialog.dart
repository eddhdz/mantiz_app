import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/activate_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

class ActivateTicketDialog extends StatelessWidget {
  final int fkMaintenance;
  final int openByPartner;
  const ActivateTicketDialog({
    super.key,
    required this.fkMaintenance,
    required this.openByPartner,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reactivar servicio'),
      content:
          const Text('¿Estás seguro de que deseas reactivar este servicio?'),
      actions: [
        TextButton(
          onPressed: () {
            // Cierra el diálogo y retorna 'false' para indicar que se canceló
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancelar'),
        ),
        Consumer<ActivateProvider>(
          builder: (context, provider, child) {
            if (provider.status == DataStatus.loading) {
              return const CircularProgressIndicator();
            }
            return ElevatedButton(
              onPressed: () async {
                await provider.activateTicket(fkMaintenance, openByPartner);
                if (provider.status == DataStatus.success) {
                  final addMessageProvider = Provider.of<AddMessageProvider>(
                    // ignore: use_build_context_synchronously
                    context,
                    listen: false,
                  );
                  const message =
                      'Servicio reactivado. El ticket ha sido activado nuevamente para su seguimiento.';

                  await addMessageProvider.addMessage(
                      fkMaintenance, openByPartner, message);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: veryLightGray,
                        ),
                        Text(
                          'Ticket activado con exito',
                          style: TextStyle(color: veryLightGray),
                        )
                      ],
                    ),
                    backgroundColor: mediumGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    padding: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 3),
                  ));
                  Navigator.pushNamedAndRemoveUntil(
                      // ignore: use_build_context_synchronously
                      context,
                      Routes.home,
                      (route) => false);
                }
              },
              child: const Text('Aceptar'),
            );
          },
        ),
      ],
    );
  }
}
