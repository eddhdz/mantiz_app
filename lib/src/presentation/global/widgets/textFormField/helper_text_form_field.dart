import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/colors.dart';

Widget buildTextFormField({
  required String hintText,
  required IconData icon,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType keyboardType = TextInputType.text,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  void Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.blueAccent), // Focused border color
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          // Error border for validation
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // Error border when focused
          borderSide: BorderSide(color: Colors.red.shade700, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(
          icon,
          color: sidonPrimaryColor,
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
      ),
    ),
  );
}
