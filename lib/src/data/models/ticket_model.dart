import 'package:mantiz/src/data/models/attendance_model.dart';
import 'package:mantiz/src/data/models/device_model.dart';
import 'package:mantiz/src/data/models/photo_evidence_model.dart';
import 'package:mantiz/src/data/models/user_model.dart';

class TicketModel {
  int ticketId;
  String folio;
  String? title;
  String? reason;
  String type;
  String area;
  String status;
  String? scheduleat;
  UserModel createdBy;
  String createdat;
  UserModel? updatedby;
  String? updatedat;
  PhotoEvidenceModel photoevidence;
  AttendanceModel attendance;
  // List<DeviceModel> devices;

  TicketModel({
    required this.ticketId,
    required this.folio,
    required this.title,
    required this.reason,
    required this.type,
    required this.area,
    required this.status,
    required this.scheduleat,
    required this.createdBy,
    required this.createdat,
    this.updatedby,
    this.updatedat,
    required this.photoevidence,
    required this.attendance,
    // required this.devices,
  });

  TicketModel.init()
      : ticketId = 0,
        folio = '',
        title = '',
        reason = '',
        type = '',
        area = '',
        status = '',
        scheduleat = '',
        createdBy = UserModel.init(),
        createdat = '',
        updatedby = null,
        updatedat = null,
        photoevidence = PhotoEvidenceModel.init(),
        attendance = AttendanceModel.init();
  // devices = [];

  // factory TicketModel.fromJson(Map<String, dynamic> json) {
  //   return TicketModel(
  //       ticketId: int.parse(json['ticketId'].toString()),
  //       folio: json['folio'],
  //       title: json['title'],
  //       reason: json['reason'],
  //       type: json['type'],
  //       area: json['area'],
  //       status: json['status'],
  //       scheduleat: json['scheduleat'],
  //       createdBy: UserModel.fromJson(json['createdBy']),
  //       createdat: json['createdat'],
  //       updatedby: json['updatedby'] != null ? UserModel.fromJson(json['updatedby']) : null,
  //       updatedat: json['updatedat'],
  //       photoevidence: PhotoEvidenceModel.fromJson(json['photoevidence']),
  //       attendance: AttendanceModel.fromJson(json['attendance']),
  //       devices: json['devices']);
  // }

  // Map<String, dynamic> toJson() => {
  //       'ticketId': ticketId,
  //       'folio': folio,
  //       'title': title,
  //       'reason': reason,
  //       'type': type,
  //       'area': area,
  //       'status': status,
  //       'scheduleat': scheduleat,
  //       'createdBy': createdBy.toJson(),
  //       'createdat': createdat,
  //       'updatedby': updatedby?.toJson(),
  //       'updatedat': updatedat,
  //       'photoevidence': photoevidence.toJson(),
  //       'attendance': attendance.toJson(),
  //       'devices': devices,
  //     };
}
