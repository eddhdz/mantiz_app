import 'package:flutter/material.dart';

class GeneralTextForm extends StatelessWidget {
  String label;
  bool enable;
  Color objectsColor;
  Color textColor;
  String? Function(String?)? validator;
  ValueChanged<String> onChange;

  GeneralTextForm(
      {super.key,
      required this.label,
      required this.enable,
      required this.objectsColor,
      required this.textColor,
      required this.validator,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator!(value),
      onChanged: (value) => onChange(value),
      obscureText: true,
      enabled: enable,
      cursorColor: objectsColor,
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
