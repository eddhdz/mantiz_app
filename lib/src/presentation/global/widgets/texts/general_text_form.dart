import 'package:flutter/material.dart';

class GeneralTextForm extends StatelessWidget {
  final String label;
  final bool enable;
  final Color objectsColor;
  final Color textColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChange;
  final TextEditingController controller;

  const GeneralTextForm(
      {super.key,
      required this.label,
      required this.enable,
      required this.objectsColor,
      required this.textColor,
      required this.obscureText,
      required this.validator,
      required this.onChange,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator!(value),
      onChanged: (value) => onChange(value),
      obscureText: obscureText,
      enabled: enable,
      cursorColor: objectsColor,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: textColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: objectsColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: objectsColor,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
