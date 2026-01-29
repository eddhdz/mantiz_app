import 'package:flutter/material.dart';

import '../../../../../data/models/floating_button_properties_model.dart';
import '../../../colors.dart';
import '../../buttons/button_box_horizontal.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            child: ButtonBoxHorizontal(buttons: [
          FloatingButtonPropertiesModel(
              icon: Icons.replay_outlined,
              backGround: blueLightGlobalColor,
              foreGround: whiteGlobalColor,
              onPressed: () async {},
              label: 'Recargar pantalla',
              heroTag: 'btnAddTicket'),
        ]))
      ],
    );
  }
}
