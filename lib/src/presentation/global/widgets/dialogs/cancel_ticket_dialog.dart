import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/cancel_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

class CancelTicketDialog extends StatelessWidget {
  final int fkMaintenance;
  final int cancelByPartner;
  const CancelTicketDialog({
    super.key,
    required this.fkMaintenance,
    required this.cancelByPartner,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController notesController = TextEditingController();
    return AlertDialog(
      title: const Text('Cancelar servicio'),
      content: TextField(
        controller: notesController,
        maxLines: 4, // Permite múltiples líneas para la nota
        decoration: const InputDecoration(
          hintText: 'Escribe el motivo de la cancelación...',
          labelText: 'Motivo',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cierra el diálogo sin hacer nada
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        Consumer<CancelProvider>(
          builder: (context, provider, child) {
            if (provider.status == DataStatus.loading) {
              return const CircularProgressIndicator();
            }

            return ElevatedButton(
              onPressed: () async {
                final String cancelReason = notesController.text.trim();

                if (cancelReason.isNotEmpty) {
                  await provider.fetchCancelTicket(fkMaintenance, cancelByPartner, cancelReason);

                  if (provider.status == DataStatus.success) {
                    final addMessageProvider = Provider.of<AddMessageProvider>(
                      // ignore: use_build_context_synchronously
                      context,
                      listen: false,
                    );
                    String message = 'Ticket cancelado desde app movil: $cancelReason';

                    await addMessageProvider.addMessage(fkMaintenance, cancelByPartner, message);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: veryLightGray,
                          ),
                          Text(
                            'Ticket cancelado con exito',
                            style: TextStyle(color: veryLightGray),
                          )
                        ],
                      ),
                      backgroundColor: mediumGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      padding: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 3),
                    ));
                    Navigator.pushNamedAndRemoveUntil(
                        // ignore: use_build_context_synchronously
                        context,
                        Routes.home,
                        (route) => false);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: veryLightGray,
                        ),
                        Text(
                          'Cancelación invalida',
                          style: TextStyle(color: veryLightGray),
                        )
                      ],
                    ),
                    backgroundColor: mediumGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 3),
                  ));
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
