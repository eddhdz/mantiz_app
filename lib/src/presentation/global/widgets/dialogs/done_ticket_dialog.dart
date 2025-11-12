import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../../domain/providers/ticket_detail/done_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DoneTicketDialog extends StatelessWidget {
  final int ticketId;
  final int userId;
  const DoneTicketDialog({
    super.key,
    required this.ticketId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController notesController = TextEditingController();
    final ImagePicker picker = ImagePicker();
    File? evidencePhoto;
    File? evidencePhoto360;
    final vm = Provider.of<NewTicketViewVM>(context);

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        Future<ImageSource?> showImageSourceDialog(BuildContext context) async {
          return showDialog<ImageSource>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Seleccionar origen'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: const Text('Cámara'),
                        onTap: () {
                          Navigator.of(dialogContext).pop(ImageSource.camera);
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        child: const Text('Galería'),
                        onTap: () {
                          Navigator.of(dialogContext).pop(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        Future<void> pickImage(bool is360) async {
          final ImageSource? source = await showImageSourceDialog(context);
          if (source == null) return; // User canceled the dialog

          final XFile? pickedFile = await picker.pickImage(
            source: source,
            imageQuality: 50,
          );
          if (pickedFile != null) {
            setState(() {
              if (is360) {
                evidencePhoto360 = File(pickedFile.path);
              } else {
                evidencePhoto = File(pickedFile.path);
              }
            });
          }
        }

        return AlertDialog(
          title: const Text('Terminar servicio'),
          content: SingleChildScrollView(
            child: Column(
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
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            Consumer<DoneProvider>(
              builder: (context, provider, child) {
                if (provider.status == DataStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () async {
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            padding: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 3),
                          ));
                        }
                      }

                      if (provider.status == DataStatus.success) {
                        final addMessageProvider =
                            Provider.of<AddMessageProvider>(
                          // ignore: use_build_context_synchronously
                          context,
                          listen: false,
                        );
                        String message =
                            'Ticket finalizado desde app movil: $finishReason';

                        await addMessageProvider.addMessage(
                            ticketId, userId, message);
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          padding: const EdgeInsets.all(10),
                          duration: const Duration(seconds: 3),
                        ));
                        vm.vmInit();
                        Navigator.pushNamedAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            Routes.startingPoint,
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
            )
          ],
        );
      },
    );
  }
}
