import 'package:flutter/material.dart';

import '../../viewers/image_viewer.dart';
import '../../viewers/video_viewer.dart';
import '../../../pages/new_ticket/views/new_ticket_view_vm.dart';
import '../../colors.dart';
import '../customs/custom_dialog_general.dart';
import 'package:mantiz/src/presentation/global/widgets/new_ticket_redesign/media_button.dart';

import 'package:provider/provider.dart';

class MediaEvidenceForm extends StatelessWidget {
  const MediaEvidenceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewTicketViewVM>(context);

    return Column(
      children: [
        const SizedBox(height: 10),
        vm.mediaFile == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MediaButton(
                      icon: Icons.camera_alt,
                      label: "FOTO",
                      onTap: (context) async {
                        await vm.showMediaSourceDialog(context: context, isVideo: false, onCamera: vm.takePhoto, onGallery: vm.pickImage);
                      }),
                  MediaButton(
                      icon: Icons.videocam,
                      label: "VIDEO",
                      onTap: (parentContext) async {
                        await vm.showMediaSourceDialog(
                            context: parentContext,
                            isVideo: true,
                            onCamera: vm.recordVideo,
                            onGallery: (_) async {
                              await vm.pickVideo(parentContext);

                              if (!parentContext.mounted) return;

                              if (vm.isLongVideo != null) {
                                if (vm.isLongVideo == true) {
                                  await showDialog(
                                    context: parentContext,
                                    builder: (context) {
                                      return const CustomDialogGeneral(
                                          descriptions: 'El video debe tener una duración menor a 10 segundos.',
                                          text: 'Ok',
                                          urlImage: 'lib/src/assets/customs/Exception@4x.png',
                                          altura: 200);
                                    },
                                  );
                                }
                              }
                            });
                      }),
                ],
              )
            : Dismissible(
                key: const ValueKey("media"),
                direction: DismissDirection.up,
                onDismissed: (_) async => await vm.onDelete(),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: (vm.isVideo != null && vm.isVideo == true) ? VideoViewer(path: vm.pathVideoImage!, loop: true) : ImageViewer(file: vm.evidence!),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.swipe_up, color: sidonPrimaryColor),
                    ),
                  ],
                ),
              ),
        const SizedBox(height: 10),
      ],
    );
  }
}
