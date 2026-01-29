import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/done_provider.dart';
import 'package:mantiz/src/presentation/global/colors.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../routes/routes.dart';
import '../../new_ticket/views/new_ticket_view_vm.dart';

class ValidationView extends StatelessWidget {
  final int ticketId;
  final int userId;
  const ValidationView({
    super.key,
    required this.ticketId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController notesController = TextEditingController();
    // final ImagePicker picker = ImagePicker();
    File? evidencePhoto360;
    final vm = Provider.of<NewTicketViewVM>(context);
    return Scaffold(
      backgroundColor: sidonSecondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Validación',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Finalizar servicio",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Motivo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Escribe el motivo de finalización...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Evidencia',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => vm.pickImage(context),
                        icon: const Icon(Icons.photo),
                        label: const Text('Galería'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => vm.takePhoto(context),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camara'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Contenedores para mostrar las fotos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (vm.evidence != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(
                          vm.evidence!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (evidencePhoto360 != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(
                          evidencePhoto360!,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Consumer<DoneProvider>(
              builder: (context, provider, child) {
                if (provider.status == DataStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton.icon(
                  onPressed: () async{
                    final String finishReason = notesController.text.trim();
                    if (finishReason.isNotEmpty) {
                      // final String? base64Photo = evidencePhoto != null
                      //     ? base64Encode(evidencePhoto!.readAsBytesSync())
                      //     : null;
                      // final String? base64Photo360 = evidencePhoto360 != null
                      //     ? base64Encode(evidencePhoto360!.readAsBytesSync())
                      //     : null;
                      if (vm.base64 == null && vm.base64!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: veryLightGray,
                              ),
                              Text(
                                'Debes tener cargada una imágen',
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
                      } else {
                        await vm.savePhoto(context);
                        if (vm.finishSavePhoto) {
                          await provider.fetchDoneTicket(
                            ticketId,
                            userId,
                            finishReason,
                            jsonEncode(vm.photoEvidenceModel!.toJson()),
                            '',
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: veryLightGray,
                                ),
                                Text(
                                  'Ocurrio un error al guardar la foto, vuelve a intentar el procedimiento',
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
                      }

                      if (provider.status == DataStatus.success) {
                        final addMessageProvider = Provider.of<AddMessageProvider>(
                          // ignore: use_build_context_synchronously
                          context,
                          listen: false,
                        );
                        String message = 'Ticket finalizado desde app movil: $finishReason';

                        await addMessageProvider.addMessage(ticketId, userId, message);
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: veryLightGray,
                              ),
                              Text(
                                'Ticket finalizado con exito',
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
                        vm.vmInit();
                        Navigator.pushNamedAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            Routes.newTicket,
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
                              'Por favor, escribe el motivo de la finalización',
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
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Aceptar y finalizar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sidonPrimaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets de Soporte ---
}
