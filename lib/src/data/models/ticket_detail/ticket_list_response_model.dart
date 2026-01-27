// -----------------------------------------------------------------------------
// MODELO PRINCIPAL
// -----------------------------------------------------------------------------

class TicketListResponseModel {
  final ResponseModel response;
  final List<TicketDetailModel> list;

  TicketListResponseModel({
    required this.response,
    required this.list,
  });

  factory TicketListResponseModel.fromJson(Map<String, dynamic> json) {
    return TicketListResponseModel(
      response: ResponseModel.fromJson(json['response']),
      list: (json['list'] as List<dynamic>)
          .map((itemJson) => TicketDetailModel.fromJson(itemJson))
          .toList(),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: ResponseModel
// -----------------------------------------------------------------------------

class ResponseModel {
  final int id;
  final String msgSpa;

  ResponseModel({
    required this.id,
    required this.msgSpa,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['id'],
      msgSpa: json['msgSpa'],
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: TicketModel (ACTUALIZADO para Device)
// -----------------------------------------------------------------------------

class TicketDetailModel {
  final int ticketId;
  final int folio;
  final String showFolio;
  final String title;
  final String reason;
  final String type;
  final String area;
  final String status;
  final PriceModel? price;
  final PhotoModel? photo;
  final CreatedByModel createdby;
  final CreatedByModel? updatedby;
  final AssignmentModel? assignment; // Puede ser null
  final FollowupModel followup;
  final DeviceModel? device;

  TicketDetailModel({
    required this.ticketId,
    required this.folio,
    required this.showFolio,
    required this.title,
    required this.reason,
    required this.type,
    required this.area,
    required this.status,
    required this.price,
    required this.photo,
    required this.createdby,
    required this.updatedby,
    required this.assignment,
    required this.followup,
    required this.device, // ⬅️ CAMBIADO
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    // Manejo de 'device'/'devices': Intentamos leer 'device', si no está, comprobamos 'devices' (si es una lista vacía, lo ignoramos).
    dynamic deviceJson = json['device'] ??
        (json['devices'] is List && (json['devices'] as List).isNotEmpty
            ? json['devices'][0] // Si era una lista con un elemento
            : null);

    return TicketDetailModel(
      ticketId: json['ticketId'],
      folio: json['folio'],
      showFolio: json['showFolio'],
      title: json['title'],
      reason: json['reason'],
      type: json['type'],
      area: json['area'],
      status: json['status'],

      price: json['price'] != null ? PriceModel.fromJson(json['price']) : null,
      photo: json['photo'] != null ? PhotoModel.fromJson(json['photo']) : null,
      updatedby: json['updatedby'] != null
          ? CreatedByModel.fromJson(json['updatedby'])
          : null,
      assignment: json['assignment'] != null
          ? AssignmentModel.fromJson(json['assignment'])
          : null, // Ahora assignment también es opcional

      createdby: CreatedByModel.fromJson(json['createdby']),
      followup: FollowupModel.fromJson(json['followup']),

      device: deviceJson != null
          ? DeviceModel.fromJson(deviceJson)
          : null, // ⬅️ Manejo de device
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: DeviceModel (NUEVO)
// -----------------------------------------------------------------------------

class DeviceModel {
  final int deviceId;
  final String name;
  final String code;
  final String type;
  final String zone;
  final String priority;
  final String level;
  final String latitud;
  final String longitud;
  final String? photo;
  final String? photo360;

  DeviceModel({
    required this.deviceId,
    required this.name,
    required this.code,
    required this.type,
    required this.zone,
    required this.priority,
    required this.level,
    required this.latitud,
    required this.longitud,
    required this.photo,
    required this.photo360,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceId: json['deviceId'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      zone: json['zone'],
      priority: json['priority'],
      level: json['level'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      photo: json['photo'],
      photo360: json['photo360'],
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: PriceModel
// -----------------------------------------------------------------------------

class PriceModel {
  final int priceId;
  final String price;
  final String? reason;
  final String createdat;
  final CreatedByModel createdby;

  PriceModel({
    required this.priceId,
    required this.price,
    required this.reason,
    required this.createdat,
    required this.createdby,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      priceId: json['priceId'],
      price: json['price'],
      reason: json['reason'],
      createdat: json['createdat'],
      createdby: CreatedByModel.fromJson(json['createdby']),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: UserModel (Usado para createdby, updatedby, asignedby, etc.)
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

// -----------------------------------------------------------------------------
// SUBMODELO: AssignmentModel
// -----------------------------------------------------------------------------

class AssignmentModel {
  final int assigmentId;
  final String asignedat;
  final String graceat;
  final String? reason;
  final CreatedByModel asignedby;
  final CreatedByModel asignedto;

  AssignmentModel({
    required this.assigmentId,
    required this.asignedat,
    required this.graceat,
    required this.reason,
    required this.asignedby,
    required this.asignedto,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      assigmentId: json['assigmentId'],
      asignedat: json['asignedat'],
      graceat: json['graceat'],
      reason: json['reason'],
      asignedby: CreatedByModel.fromJson(json['asignedby']),
      asignedto: CreatedByModel.fromJson(json['asignedto']),
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELO: FollowupModel (Contiene todas las acciones que pueden ser null)
// -----------------------------------------------------------------------------

class FollowupModel {
  final CancelModel? cancel;
  final DoneModel? done;
  final FinishModel? finish;
  final OpenModel? open;
  final RejectModel? reject;
  final ScheduleModel? schedule;
  final SuspendModel? suspend;

  FollowupModel({
    required this.cancel,
    required this.done,
    required this.finish,
    required this.open,
    required this.reject,
    required this.schedule,
    required this.suspend,
  });

  factory FollowupModel.fromJson(Map<String, dynamic> json) {
    return FollowupModel(
      cancel:
          json['cancel'] != null ? CancelModel.fromJson(json['cancel']) : null,
      done: json['done'] != null ? DoneModel.fromJson(json['done']) : null,
      finish:
          json['finish'] != null ? FinishModel.fromJson(json['finish']) : null,
      open: json['open'] != null ? OpenModel.fromJson(json['open']) : null,
      reject:
          json['reject'] != null ? RejectModel.fromJson(json['reject']) : null,
      schedule: json['schedule'] != null
          ? ScheduleModel.fromJson(json['schedule'])
          : null,
      suspend: json['suspend'] != null
          ? SuspendModel.fromJson(json['suspend'])
          : null,
    );
  }
}

// -----------------------------------------------------------------------------
// SUBMODELOS de Followup (Ejemplo: Done, Cancel, etc.)
// Nota: Muchos de estos modelos tienen una estructura similar.
// -----------------------------------------------------------------------------

class CancelModel {
  final int cancelId;
  final String canceledat;
  final String? reason;
  final CreatedByModel canceledby;

  CancelModel({
    required this.cancelId,
    required this.canceledat,
    required this.reason,
    required this.canceledby,
  });

  factory CancelModel.fromJson(Map<String, dynamic> json) {
    return CancelModel(
      cancelId: json['cancelId'],
      canceledat: json['canceledat'],
      reason: json['reason'],
      canceledby: CreatedByModel.fromJson(json['canceledby']),
    );
  }
}

class DoneModel {
  final int doneId;
  final String doneat;
  final String? reason;
  final PhotoModel? photo; // Puede ser null
  final String? photo360; // Puede ser null
  final CreatedByModel doneby;

  DoneModel({
    required this.doneId,
    required this.doneat,
    required this.reason,
    required this.photo,
    required this.photo360,
    required this.doneby,
  });

  factory DoneModel.fromJson(Map<String, dynamic> json) {
    return DoneModel(
      doneId: json['doneId'],
      doneat: json['doneat'],
      reason: json['reason'],
      photo: json['photo'] != null ? PhotoModel.fromJson(json['photo']) : null,
      photo360: json['photo360'],
      doneby: CreatedByModel.fromJson(json['doneby']),
    );
  }
}

class FinishModel {
  final int finishId;
  final String finishedat;
  final String reason;
  final PhotoModel? photo;
  final String? photo360;
  final CreatedByModel finishedby;

  FinishModel({
    required this.finishId,
    required this.finishedat,
    required this.reason,
    required this.photo,
    required this.photo360,
    required this.finishedby,
  });

  factory FinishModel.fromJson(Map<String, dynamic> json) {
    return FinishModel(
      finishId: json['finishId'],
      finishedat: json['finishedat'],
      reason: json['reason'],
      photo: json['photo'] != null ? PhotoModel.fromJson(json['photo']) : null,
      photo360: json['photo360'],
      finishedby: CreatedByModel.fromJson(json['finishedby']),
    );
  }
}

class OpenModel {
  final int openId;
  final String openedat;
  final String? reason;
  final PhotoModel? photo;
  final String? photo360;
  final CreatedByModel openedby;

  OpenModel({
    required this.openId,
    required this.openedat,
    required this.reason,
    required this.photo,
    required this.photo360,
    required this.openedby,
  });

  factory OpenModel.fromJson(Map<String, dynamic> json) {
    return OpenModel(
      openId: json['openId'],
      openedat: json['openedat'],
      reason: json['reason'],
      photo: json['photo'] != null ? PhotoModel.fromJson(json['photo']) : null,
      photo360: json['photo360'],
      openedby: CreatedByModel.fromJson(json['openedby']),
    );
  }
}

class RejectModel {
  final int rejectId;
  final String rejectedat;
  final String? reason;
  final PhotoModel? photo;
  final String? photo360;
  final CreatedByModel rejectedby;

  RejectModel({
    required this.rejectId,
    required this.rejectedat,
    required this.reason,
    required this.photo,
    required this.photo360,
    required this.rejectedby,
  });

  factory RejectModel.fromJson(Map<String, dynamic> json) {
    return RejectModel(
      rejectId: json['rejectId'],
      rejectedat: json['rejectedat'],
      reason: json['reason'],
      photo: json['photo'] != null ? PhotoModel.fromJson(json['photo']) : null,
      photo360: json['photo360'],
      rejectedby: CreatedByModel.fromJson(json['rejectedby']),
    );
  }
}

class ScheduleModel {
  final int scheduleId;
  final String scheduledat;
  final int atentionat;
  final String createdat;
  final CreatedByModel scheduledby;

  ScheduleModel({
    required this.scheduleId,
    required this.scheduledat,
    required this.atentionat,
    required this.createdat,
    required this.scheduledby,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['scheduleId'],
      scheduledat: json['scheduledat'],
      atentionat: json['atentionat'],
      createdat: json['createdat'],
      scheduledby: CreatedByModel.fromJson(json['scheduledby']),
    );
  }
}

class SuspendModel {
  final int suspendId;
  final String suspendedat;
  final String? reason;
  final CreatedByModel suspendedby;

  SuspendModel({
    required this.suspendId,
    required this.suspendedat,
    required this.reason,
    required this.suspendedby,
  });

  factory SuspendModel.fromJson(Map<String, dynamic> json) {
    return SuspendModel(
      suspendId: json['suspendId'],
      suspendedat: json['suspendedat'],
      reason: json['reason'],
      suspendedby: CreatedByModel.fromJson(json['suspendedby']),
    );
  }
}

// -----------------------------------------------------------------------------
// MODELO: PhotoModel
// -----------------------------------------------------------------------------

class PhotoModel {
  final String? uuid;
  final String? uuidapp;
  final String? name;
  final String? type;
  final String? url; // Asumiendo que puede venir como String vacío o null

  PhotoModel({
    required this.uuid,
    required this.uuidapp,
    required this.name,
    required this.type,
    required this.url,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      uuid: json['uuid'],
      uuidapp: json['uuidapp'],
      name: json['name'],
      type: json['type'],
      url: json['url'],
    );
  }
}
