import 'package:flutter/material.dart';

import '../../colors.dart';

class GeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const GeneralButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.blue.shade700;
          }
          return color; // Use the component's default.
        },
      )),
      // ElevatedButton.styleFrom(
      //   backgroundColor: color,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(borderRadius),
      //   ),
      // ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: whiteGlobalColor),
      ),
    );
  }
}
