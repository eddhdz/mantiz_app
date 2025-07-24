import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralText extends StatelessWidget {
  final String mensaje;
  final int maxLines;
  final TextOverflow overFlow;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign align;

  const GeneralText(
      {super.key,
      required this.mensaje,
      required this.maxLines,
      required this.overFlow,
      required this.size,
      required this.weight,
      required this.color,
      required this.align});

  @override
  Widget build(BuildContext context) {
    return Text(mensaje,
        textAlign: align,
        maxLines: maxLines,
        overflow: overFlow,
        style: GoogleFonts.barlow(
            color: color, fontWeight: weight, fontSize: size));
  }
}
