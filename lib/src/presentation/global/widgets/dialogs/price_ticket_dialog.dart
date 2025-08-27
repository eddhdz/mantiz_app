import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../../domain/providers/ticket_detail/price_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

import 'package:provider/provider.dart';

class PriceTicketDialog extends StatelessWidget {
  final int fkMaintenance;
  final int createdByPartner;
  const PriceTicketDialog({
    super.key,
    required this.fkMaintenance,
    required this.createdByPartner,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController costController = TextEditingController();
    return AlertDialog(
      title: const Text('Costo de servicio'),
      content: TextField(
        controller: costController,
        // ✅ Solo permite la entrada de números y el punto decimal
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          // ✅ Usa un RegExp para validar que solo haya números y un punto decimal
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        decoration: const InputDecoration(
          hintText: 'Ingresa el monto',
          labelText: 'Monto (MXN)',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        Consumer<PriceProvider>(
          builder: (context, provider, child) {
            if (provider.status == DataStatus.loading) {
              return const CircularProgressIndicator();
            }

            return ElevatedButton(
              onPressed: () async {
                // ✅ Aquí puedes obtener el valor ingresado.
                final String costText = costController.text;
                final double? cost = double.tryParse(costText);

                if (cost != null) {
                  await provider.fetchPriceTicket(
                      fkMaintenance, createdByPartner, cost);

                  if (provider.status == DataStatus.success) {
                    final addMessageProvider = Provider.of<AddMessageProvider>(
                      // ignore: use_build_context_synchronously
                      context,
                      listen: false,
                    );
                    String message =
                        'Se agrega cotización desde app movil por la cantidad de $cost MXN MAS IVA';

                    await addMessageProvider.addMessage(
                        fkMaintenance, createdByPartner, message);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: veryLightGray,
                          ),
                          Text(
                            'Ticket cotizado con exito por la cantidad de $cost',
                            style: const TextStyle(color: veryLightGray),
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
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: veryLightGray,
                        ),
                        Text(
                          'Costo invalido',
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
