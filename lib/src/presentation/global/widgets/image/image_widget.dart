import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/ticket_detail/ticket_list_response_model.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/providers/image/image_provider.dart';

class TicketImageWidget extends StatefulWidget {
  final PhotoModel photo;

  const TicketImageWidget({super.key, required this.photo});

  @override
  State<TicketImageWidget> createState() => _TicketImageWidgetState();
}

class _TicketImageWidgetState extends State<TicketImageWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ImagesProvider>().fetchImage(
            widget.photo.uuid,
            widget.photo.uuidapp,
            widget.photo.name,
            widget.photo.type,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesProvider>(
      builder: (context, provider, child) {
        if (provider.status == DataStatus.loading) {
          return Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
                child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        if (provider.status == DataStatus.error) {
          return _buildErrorWidget();
        }

        if (provider.imageBase64 != null) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  Image.memory(
                    base64Decode(provider.imageBase64!),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildErrorWidget(),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EVIDENCIA DEL SERVICIO",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, color: Colors.red),
            Text("No se pudo cargar la imagen",
                style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
