import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../colors.dart';
import '../texts/general_text.dart';

class ButtonBoxHorizontal extends StatelessWidget {
  final List<FloatingButtonPropertiesModel> buttons;

  const ButtonBoxHorizontal({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buttons.length,
            itemBuilder: (_, int index) {
              final button = buttons[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: (button.label.isEmpty)
                    ? FloatingActionButton(
                        heroTag: button.heroTag,
                        onPressed: button.onPressed,
                        backgroundColor: button.backGround,
                        foregroundColor: button.foreGround,
                        child: Icon(button.icon),
                      )
                    : FloatingActionButton.extended(
                        heroTag: button.heroTag,
                        onPressed: button.onPressed,
                        backgroundColor: button.backGround,
                        foregroundColor: button.foreGround,
                        label: GeneralText(
                            mensaje: button.label,
                            maxLines: 1,
                            overFlow: TextOverflow.ellipsis,
                            size: 12,
                            weight: FontWeight.normal,
                            color: whiteGlobalColor,
                            align: TextAlign.center),
                        icon: Icon(button.icon),
                      ),
              );
            }));
  }
}
