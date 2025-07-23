import 'package:flutter/material.dart';

class ContainerPropertiesModel {
  final double height;
  final double width;
  final Alignment alignment;
  final Color backColor;
  final Color borderColor;
  final Color shadowColor;
  final double rounded;
  final double borderWidth;
  final Widget widget;
  final EdgeInsetsGeometry margin;

  ContainerPropertiesModel(
      {required this.height,
      required this.width,
      required this.alignment,
      required this.backColor,
      required this.borderColor,
      required this.shadowColor,
      required this.rounded,
      required this.borderWidth,
      required this.widget,
      required this.margin});
}
