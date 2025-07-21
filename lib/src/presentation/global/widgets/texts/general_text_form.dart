import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/models/general_text_properties_model.dart';

class GeneralTextForm extends StatelessWidget {
  final GeneralTextPropertiesModel properties;

  const GeneralTextForm({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => properties.validator!(value),
      onChanged: (value) => properties.onChange(value),
      obscureText: properties.obscureText,
      enabled: properties.enable,
      cursorColor: properties.objectsColor,
      controller: properties.controller,
      keyboardType: properties.keyboard,
      minLines: properties.minLines,
      maxLines: properties.maxLines,
      textInputAction: TextInputAction.go,
      style: TextStyle(
        color: properties.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: properties.label,
        labelStyle: TextStyle(
          color: properties.textColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: properties.objectsColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: properties.objectsColor,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
