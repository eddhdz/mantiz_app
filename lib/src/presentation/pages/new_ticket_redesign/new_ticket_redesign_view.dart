import 'package:flutter/material.dart';

import '../../global/colors.dart';
import '../../global/widgets/customs/custom_dialog_general.dart';
import '../../global/widgets/new_ticket_redesign/media_evidence_form.dart';
import '../../global/widgets/new_ticket_redesign/technical_data_form.dart';
import '../../global/widgets/texts/general_text.dart';
import '../../routes/routes.dart';
import '../new_ticket/views/new_ticket_view_vm.dart';

import 'package:provider/provider.dart';

class NewTicketRedesignView extends StatelessWidget {
  const NewTicketRedesignView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewTicketViewVM>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        backgroundColor: sidonSecondaryColor,
        appBar: _buildAppBar(context, vm),
        body: Stepper(
          currentStep: vm.currentStep,
          onStepContinue: () async {
            await vm.onNextStep();

            if (vm.saveNextStep) {
              String desc = '', url = '';

              await vm.getPosibleError();
              if (vm.failureDescription.isEmpty) {
                // Comenzamos guardado ...
                if (context.mounted) {
                  await vm.savePhoto(context);
                }

                if (vm.finishSavePhoto) {
                  if (context.mounted) {
                    await vm.saveTicket(context);
                  }

                  if (vm.finishSaveTicket) {
                    desc = 'Ticket guardado satisfactoriamente ||Continúa agregando tickets o presiona <Cancelar> para salir.';
                    url = 'lib/src/assets/customs/Exception@4x.png';
                  } else {
                    desc = 'Ocurrió un error al guardar el ticket, vuelve a intentar el procedimiento.';
                    url = 'lib/src/assets/customs/Exception@4x.png';
                  }
                } else {
                  desc = 'Ocurrió un error al guardar la foto, vuelve a intentar el procedimiento.';
                  url = 'lib/src/assets/customs/Exception@4x.png';
                }
              } else {
                desc = vm.failureDescription;
                url = 'lib/src/assets/customs/Exception@4x.png';
              }

              if (!context.mounted) return;
              await showDialog(
                  context: context,
                  builder: (build) {
                    return CustomDialogGeneral(descriptions: desc, text: 'Ok', urlImage: url, altura: 260);
                  });

              await vm.vmInit();

              if (!context.mounted) return;
              await vm.loadCustomer(context);
            }
          },
          onStepCancel: () async {
            await vm.onBeforeStep();
          },
          controlsBuilder: (context, details) {
            final isLastStep = vm.currentStep == 1;

            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: GeneralText(
                      mensaje: isLastStep ? "Guardar" : "Siguiente",
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 16,
                      weight: FontWeight.bold,
                      color: sidonBackgroundDarkColor,
                      align: TextAlign.center,
                    ),
                  ),
                ),
                if (vm.currentStep > 0) const SizedBox(width: 12),
                if (vm.currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const GeneralText(
                        mensaje: 'Regresar',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 16,
                        weight: FontWeight.bold,
                        color: sidonBackgroundDarkColor,
                        align: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
          steps: const [
            Step(
              title: GeneralText(
                mensaje: 'Datos técnicos:',
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                size: 20,
                weight: FontWeight.bold,
                color: mediumGray,
                align: TextAlign.left,
              ),
              content: TechnicalDataForm(),
            ),
            Step(
              title: GeneralText(mensaje: 'Multimedia:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 20, weight: FontWeight.bold, color: mediumGray, align: TextAlign.left),
              content: MediaEvidenceForm(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, NewTicketViewVM vm) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: whiteGlobalColor,
      elevation: 0,
      centerTitle: false,
      title: const GeneralText(
        mensaje: 'Nuevo ticket',
        maxLines: 1,
        overFlow: TextOverflow.ellipsis,
        size: 20,
        weight: FontWeight.bold,
        color: sidonBackgroundDarkColor,
        align: TextAlign.start,
      ),
      actions: [
        (vm.isLoading)
            ? const Image(image: AssetImage('lib/src/assets/customs/Wait03@4x.gif'), fit: BoxFit.scaleDown)
            : TextButton(
                onPressed: () async {
                  await vm.vmInit();

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
                },
                child: const GeneralText(
                  mensaje: 'Cancelar',
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 14,
                  weight: FontWeight.bold,
                  color: redPrincipal,
                  align: TextAlign.right,
                ))
      ],
    );
  }
}
