import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/starting_point/starting_point_repository.dart';
import '../../models/attendance_model.dart';
import '../../models/models.dart';
import '../../models/photo_evidence_model.dart';
import '../../models/ticket_model.dart';
import '../../services/remote/starting_point/starting_point_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StartingPointImpl implements StartingPointRepository {
  final FlutterSecureStorage _storage;
  final StartingPointApi _startingPointApi;

  StartingPointImpl(this._startingPointApi, this._storage);

  @override
  Future<Either<GeneralFailure, List<MaintenancesModel>>>
      loadMaintenances() async {
    String? userUuid = await _storage.read(key: 'useruuid');

    final homeResult = await _startingPointApi.loadMaintenances(userUuid);

    return homeResult.when(
      (failure) {
        return Either.left(failure);
      },
      (responseBody) {
        List<MaintenancesModel> maintenances = [];

        final json = Map<String, dynamic>.from(jsonDecode(responseBody));

        for (var mtto in json['list'] as List) {
          MaintenancesModel maintenancesModel = MaintenancesModel.init();
          List<BranchOfficeModel> branchoffices = [];

          for (var branch in mtto['branchoffices']) {
            List<TicketModel> tickets = [];

            for (var ticket in branch['tickets']) {
              var ticketMap = Map<String, dynamic>.from(ticket);

              //! CreatedBy ...
              UserModel createdBy = UserModel.onInit();
              if (ticketMap['createdby'] != null) {
                var createdByMap =
                    Map<String, dynamic>.from(ticketMap['createdby']);
                createdBy = UserModel(
                  useruuid: createdByMap['useruuid'],
                  name: createdByMap['name'],
                  email: createdByMap['email'],
                  phone: createdByMap['phone'],
                );
              }

              //! PhotoEvidence ...
              PhotoEvidenceModel photoevidence = PhotoEvidenceModel.onInit();
              if (ticketMap['photoevidence'] != null) {
                var photoevidenceMap =
                    Map<String, dynamic>.from(ticketMap['photoevidence']);
                photoevidence = PhotoEvidenceModel(
                  uuid: photoevidenceMap['uuid'],
                  uuidapp: photoevidenceMap['uuidapp'],
                  name: photoevidenceMap['name'],
                  type: photoevidenceMap['type'],
                  url: photoevidenceMap['url'],
                );
              }

              AttendanceModel attendance = AttendanceModel.init();
              if (ticketMap['attendance'] != null) {
                var attendanceMap =
                    Map<String, dynamic>.from(ticketMap['attendance']);

                //! AsignedTo ...
                UserModel asignedto = UserModel.onInit();
                if (attendanceMap['asignedto'] != null) {
                  var asignedtoMap =
                      Map<String, dynamic>.from(attendanceMap['asignedto']);

                  asignedto = UserModel(
                    useruuid: asignedtoMap['useruuid'],
                    name: asignedtoMap['name'],
                    email: asignedtoMap['email'],
                    phone: asignedtoMap['phone'],
                  );
                }

                //! Attendance ...
                attendance = AttendanceModel(
                  atentionat: attendanceMap['atentionat'],
                  atentiontime: attendanceMap['atentiontime'],
                  asignedto: asignedto,
                  asignedat: attendanceMap['asignedat'],
                  estimatedtime: attendanceMap['estimatedtime'],
                );
              }

              //! Ticket ...
              TicketModel ticketModel = TicketModel.init();
              ticketModel = TicketModel(
                  ticketId: int.parse(ticketMap['ticketId'].toString()),
                  folio: ticketMap['showFolio'],
                  title: ticketMap['title'],
                  reason: ticketMap['reason'],
                  type: ticketMap['type'],
                  area: ticketMap['area'],
                  status: ticketMap['status'],
                  scheduleat: ticketMap['scheduleat'],
                  createdBy: createdBy,
                  createdat: ticketMap['createdat'],
                  photoevidence: photoevidence,
                  attendance: attendance);

              // //! Tickets ...
              tickets.add(ticketModel);
            }

            var branchofficeMap = Map<String, dynamic>.from(branch);
            BranchOfficeModel branchofficeModel = BranchOfficeModel.init();
            branchofficeModel = BranchOfficeModel(
                branchofficeId: branchofficeMap['branchofficeId'],
                branchoffice: branchofficeMap['branchoffice'],
                address: branchofficeMap['address'],
                latitude: branchofficeMap['latitude'],
                longitude: branchofficeMap['longitude'],
                clave: branchofficeMap['clave'],
                tickets: tickets,
                zones: []);

            //! brachoffice ...
            branchoffices.add(branchofficeModel);
          }

          //! Maintenances ...
          maintenancesModel.id = int.parse(mtto['id'].toString());
          maintenancesModel.customer = mtto['customer'];
          maintenancesModel.branchoffices = branchoffices;

          maintenances.add(maintenancesModel);
        }

        return Either.right(maintenances);
      },
    );
  }
}
