import 'package:mantiz/src/data/models/attendance_model.dart';
import 'package:mantiz/src/data/models/photo_evidence_model.dart';
import 'package:mantiz/src/data/models/user_model.dart';

class TicketModel {
  int ticketId;
  int folio;
  String showFolio;
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

  TicketModel({
    required this.ticketId,
    required this.folio,
    required this.showFolio,
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
  });

  TicketModel.init()
      : ticketId = 0,
        folio = 0,
        showFolio = '',
        title = '',
        reason = '',
        type = '',
        area = '',
        status = '',
        scheduleat = '',
        createdBy = UserModel.onInit(),
        createdat = '',
        updatedby = null,
        updatedat = null,
        photoevidence = PhotoEvidenceModel.onInit(),
        attendance = AttendanceModel.init();
}
