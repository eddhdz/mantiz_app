import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FloatingButtonPropertiesModel {
  IconData icon;
  Color backGround;
  Color foreGround;
  void Function()? onPressed;
  String label;
  String heroTag;

  FloatingButtonPropertiesModel(
      {required this.icon,
      required this.backGround,
      required this.foreGround,
      required this.onPressed,
      required this.label,
      required this.heroTag});
}
