// -----------------------------------------------------------------------------
// MODELO PRINCIPAL: MessageResponseModel
// -----------------------------------------------------------------------------

class MessageResponseModel {
  final Response response;
  final List<TicketChatModel> list;

  MessageResponseModel({
    required this.response,
    required this.list,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      response: Response.fromJson(json['response']),
      list: (json['list'] as List<dynamic>)
          .map((itemJson) => TicketChatModel.fromJson(itemJson))
          .toList(),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: ResponseModel (Manejo de la respuesta genérica)
// -----------------------------------------------------------------------------

class Response {
  final int id;
  final String msgSpa;

  Response({
    required this.id,
    required this.msgSpa,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['id'],
      msgSpa: json['msgSpa'],
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: TicketChatModel (Contiene la lista de mensajes de chat)
// -----------------------------------------------------------------------------

class TicketChatModel {
  final int folio;
  final String title;
  final List<ChatMessageModel> chat;

  TicketChatModel({
    required this.folio,
    required this.title,
    required this.chat,
  });

  factory TicketChatModel.fromJson(Map<String, dynamic> json) {
    return TicketChatModel(
      folio: json['folio'],
      title: json['title'],
      chat: (json['chat'] as List<dynamic>)
          .map((itemJson) => ChatMessageModel.fromJson(itemJson))
          .toList(),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: ChatMessageModel (Mensaje individual)
// -----------------------------------------------------------------------------

class ChatMessageModel {
  final int chatId;
  final String body;
  final int fkSender;
  final String createdat;
  final String? updatedat; // Puede ser null
  final CreatedByModel createdby;

  ChatMessageModel({
    required this.chatId,
    required this.body,
    required this.fkSender,
    required this.createdat,
    required this.updatedat,
    required this.createdby,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      chatId: json['chatId'],
      body: json['body'],
      fkSender: json['fkSender'],
      createdat: json['createdat'],
      updatedat: json['updatedat'],
      createdby: CreatedByModel.fromJson(json['createdby']),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: CreatedByModel (Reutilizado para el usuario que creó el mensaje)
// -----------------------------------------------------------------------------

class CreatedByModel {
  final String useruuid;
  final String name;
  final String email;
  final String phone;

  CreatedByModel({
    required this.useruuid,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      useruuid: json['useruuid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
