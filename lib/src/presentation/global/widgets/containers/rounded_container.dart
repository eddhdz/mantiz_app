import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';

class RoundedContainer extends StatelessWidget {
  final ContainerPropertiesModel containerPropertiesModel;

  const RoundedContainer({super.key, required this.containerPropertiesModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerPropertiesModel.height,
      width: containerPropertiesModel.width,
      margin: containerPropertiesModel.margin,
      decoration: BoxDecoration(
        color: containerPropertiesModel.backColor,
        border: Border.all(
            width: containerPropertiesModel.borderWidth,
            color: containerPropertiesModel.borderColor),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(containerPropertiesModel.rounded),
          bottomLeft: Radius.circular(containerPropertiesModel.rounded),
          topLeft: Radius.circular(containerPropertiesModel.rounded),
          topRight: Radius.circular(containerPropertiesModel.rounded),
        ),
        boxShadow: [
          BoxShadow(
            color: containerPropertiesModel.shadowColor,
            offset: const Offset(9, 9),
            blurRadius: 6,
          ),
        ],
      ),
      alignment: containerPropertiesModel.alignment,
      child: containerPropertiesModel.widget,
    );
  }
}
