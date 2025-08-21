import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/add_message_provider.dart';

import '../../../../data/models/ticket_detail/message_response_model.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/tracking_provider.dart';
import '../../../global/colors.dart';

import 'package:provider/provider.dart';

class TicketTrackingView extends StatefulWidget {
  final int fkMaintenance;
  final int currentUserId;
  const TicketTrackingView({
    super.key,
    required this.fkMaintenance,
    required this.currentUserId,
  });

  @override
  State<TicketTrackingView> createState() => _TicketTrackingViewState();
}

class _TicketTrackingViewState extends State<TicketTrackingView> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TrackingProvider>(context, listen: false)
          .fetchMessages(widget.fkMaintenance);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final messageText = _messageController.text;
      _messageController.clear(); // Limpia el campo de texto inmediatamente

      final addMessageProvider =
          Provider.of<AddMessageProvider>(context, listen: false);
      final trackingProvider =
          Provider.of<TrackingProvider>(context, listen: false);

      await addMessageProvider.addMessage(
          widget.fkMaintenance, widget.currentUserId, messageText);

      if (addMessageProvider.status == DataStatus.success) {
        await trackingProvider.fetchMessages(widget.fkMaintenance);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error al enviar el mensaje, inetantalo de nuevo'),
          backgroundColor: mediumGray,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<TrackingProvider>(
            builder: (context, provider, child) {
              switch (provider.status) {
                case DataStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case DataStatus.error:
                  return const Center(
                    child: Text('Error al cargar los mensajes'),
                  );
                case DataStatus.noData:
                  return const Center(
                    child: Text('El ticket no tiene mensajes de seguimiento'),
                  );
                case DataStatus.loaded:
                  return ListView.builder(
                    reverse: false,
                    itemCount: provider.messages!.length,
                    itemBuilder: (context, index) {
                      final message = provider.messages![index];
                      final isMyMessage =
                          message.fkSender == widget.currentUserId;
                      return _buildMessageBubble(
                        message: message,
                        isMyMessage: isMyMessage,
                      );
                    },
                  );
                default:
                  return const Center(
                    child: Text(
                        'Ocurrio un error al tratar de cargar los mensajes'),
                  );
              }
            },
          )),
          const Divider(
            height: 1,
          ),
          _buildMessageComposer(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required Message message,
    required bool isMyMessage,
  }) {
    final alignment =
        isMyMessage ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMyMessage ? darkGray : lightGray;
    final textColor = isMyMessage ? veryLightGray : darkGray;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth:
              250, // Limita el ancho de la burbuja para que no ocupe todo el espacio
        ),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isMyMessage
                ? const Radius.circular(20)
                : const Radius.circular(5),
            bottomRight: isMyMessage
                ? const Radius.circular(5)
                : const Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.body,
              style: TextStyle(
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd-MM-yyyy h:mm a').format(message.createdAt),
              style: TextStyle(
                fontSize: 10,
                color: textColor.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              message.profile.fullname,
              style: TextStyle(
                  fontSize: 10,
                  color: textColor.withValues(
                    alpha: 0.8,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            decoration: const BoxDecoration(
              color: mediumDarkGray,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: veryLightGray),
              onPressed: _handleSendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
