import 'package:flutter/material.dart';

class GeneralTextPropertiesModel {
  final String label;
  final bool enable;
  final Color objectsColor;
  final Color textColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChange;
  final TextEditingController controller;
  final TextInputType keyboard;
  final int minLines;
  final int maxLines;

  GeneralTextPropertiesModel(
      {required this.label,
      required this.enable,
      required this.objectsColor,
      required this.textColor,
      required this.obscureText,
      required this.validator,
      required this.onChange,
      required this.controller,
      required this.keyboard,
      required this.minLines,
      required this.maxLines});
}
