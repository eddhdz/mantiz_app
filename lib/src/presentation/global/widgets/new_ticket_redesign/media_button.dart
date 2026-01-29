import 'package:flutter/material.dart';

import '../../colors.dart';
import '../texts/general_text.dart';

class MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Future<void> Function(BuildContext context)? onTap;

  const MediaButton({required this.icon, required this.label, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(context) : null,
      child: Column(children: [
        Icon(icon, size: 48, color: sidonPrimaryColor),
        const SizedBox(height: 4),
        GeneralText(
          mensaje: label,
          maxLines: 1,
          overFlow: TextOverflow.ellipsis,
          size: 14,
          weight: FontWeight.bold,
          color: sidonPrimaryColor,
          align: TextAlign.center,
        )
      ]),
    );
  }
}
