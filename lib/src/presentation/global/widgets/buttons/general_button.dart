import 'package:flutter/material.dart';

import '../../colors.dart'; // Assuming this contains whiteGlobalColor

class GeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final Size? minimumSize;
  final BorderSide? side;
  final bool isLoading;

  const GeneralButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.minimumSize,
    this.side,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = textColor ?? veryLightGray;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: effectiveTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10.0),
          side: side ?? BorderSide.none,
        ),
        padding: padding,
        elevation: elevation,
        minimumSize: minimumSize,
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: effectiveTextColor,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: effectiveTextColor,
              ),
            ),
    );
  }
}
