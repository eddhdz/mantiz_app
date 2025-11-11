import 'package:flutter/material.dart';
import 'dart:io';

class ImageViewer extends StatelessWidget {
  final File file;

  const ImageViewer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Image.file(file, fit: BoxFit.scaleDown);
  }
}
