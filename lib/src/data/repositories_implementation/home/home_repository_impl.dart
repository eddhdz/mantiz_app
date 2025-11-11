import 'dart:convert';

// import 'package:flutter/material.dart';

import 'package:mantiz/src/data/models/attendance_model.dart';
import 'package:mantiz/src/data/models/device_model.dart';
import 'package:mantiz/src/data/models/photo_evidence_model.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/home/home_repository.dart';
import '../../models/models.dart';
// import '../../models/photo_evidence_model.dart';
import '../../models/ticket_model.dart';
import '../../services/remote/home/home_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeRepositoryImpl implements HomeRepository {
  final FlutterSecureStorage _storage;
  final HomeApi _homeApi;

  HomeRepositoryImpl(this._homeApi, this._storage);

  @override
  Future<Either<GeneralFailure, List<MaintenancesModel>>>
      loadMaintenances() async {
    // String? fkPartnerLicence = await _storage.read(key: 'fkPartnerLicence');
    // String? fkProfileCustomer = await _storage.read(key: 'FkCustomer');
    // String? fkProfileSupplier = await _storage.read(key: 'FkSupplierProfile');
    // String? currentFkProfile = fkProfileCustomer ?? fkProfileSupplier ?? fkPartnerLicence;
    // String role = 'partner';

    // if (fkProfileCustomer != null && fkProfileSupplier == null) {
    //   role = 'customer';
    // } else if (fkProfileCustomer == null && fkProfileSupplier != null) {
    //   role = 'supplier';
    // }
    String? userUuid = await _storage.read(key: 'useruuid');

    final homeResult = await _homeApi.loadMaintenances(userUuid);

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
              var b = 1000;

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

              var a = 1000;

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

              var c = 1000;

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

                var d = 1000;

                //! Attendance ...
                attendance = AttendanceModel(
                  atentionat: attendanceMap['atentionat'],
                  atentiontime: attendanceMap['atentiontime'],
                  asignedto: asignedto,
                  asignedat: attendanceMap['asignedat'],
                  estimatedtime: attendanceMap['estimatedtime'],
                );
              }

              var e = 1000;

              var f = 1000;
              //! Ticket ...
              TicketModel ticketModel = TicketModel.init();
              ticketModel = TicketModel(
                  ticketId: int.parse(ticketMap['ticketId'].toString()),
                  folio: ticketMap['folio'],
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

            var g = 1000;

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

        // for (var ticket in json['maintenances'] as List) {
        //   //! branchoffice ...
        //   var branchOffice = Map<String, dynamic>.from(jsonDecode(ticket['branchoffice']));
        //   BranchOfficeModel branchOfficeModel = BranchOfficeModel(
        //       id: int.parse(branchOffice['id'].toString()),
        //       fkSubcompany: int.parse(branchOffice['fkSubcompany'].toString()),
        //       description: branchOffice['description'],
        //       location: branchOffice['location'],
        //       latitud: branchOffice['latitud'],
        //       longitud: branchOffice['longitud'],
        //       imagen: branchOffice['imagen'],
        //       clave: branchOffice['clave'],
        //       subcompany: branchOffice['subcompany'],
        //       uuidBO: branchOffice['uuidBO']);

        //   //! PhotoEvidence ...
        //   PhotoEvidenceModel? photoEvidenceModel;
        //   if (ticket['photoevidence'] != null) {
        //     var photoEvidence = Map<String, dynamic>.from(jsonDecode(ticket['photoevidence']));
        //     photoEvidenceModel = PhotoEvidenceModel(
        //       uuid: photoEvidence['uuid'],
        //       uuidapp: photoEvidence['uuidapp'],
        //       name: photoEvidence['name'],
        //       type: photoEvidence['type'],
        //       url: (photoEvidence['url'] != null) ? photoEvidence['url'] : '',
        //     );
        //   }

        //   //! whopartnercreated ...
        //   WhoPartnerCreatedModel? whoPartnerCreatedModel;
        //   if (ticket['whopartnercreated'] != null) {
        //     var whoPartnerCreated = Map<String, dynamic>.from(jsonDecode(ticket['whopartnercreated']));

        //     whoPartnerCreatedModel = WhoPartnerCreatedModel(
        //         idProfile: int.parse(whoPartnerCreated['idProfile'].toString()),
        //         fullname: whoPartnerCreated['fullname'],
        //         email: whoPartnerCreated['email'],
        //         phone: whoPartnerCreated['phone'],
        //         userToken: whoPartnerCreated['userToken'],
        //         typeUser: whoPartnerCreated['typeUser'],
        //         typeRole: whoPartnerCreated['typeRole']);
        //   }

        //   //! whocustomercreated ...
        //   WhoCustomerCreatedModel? whoCustomerCreatedModel;
        //   if (ticket['whocustomercreated'] != null) {
        //     var whoCustomerCreated = Map<String, dynamic>.from(jsonDecode(ticket['whocustomercreated']));

        //     whoCustomerCreatedModel = WhoCustomerCreatedModel(
        //         idProfile: int.parse(whoCustomerCreated['idProfile'].toString()),
        //         fullname: whoCustomerCreated['fullname'],
        //         email: whoCustomerCreated['email'],
        //         phone: whoCustomerCreated['phone'],
        //         userToken: whoCustomerCreated['userToken'],
        //         typeUser: whoCustomerCreated['typeUser'],
        //         typeRole: whoCustomerCreated['typeRole']);
        //   }

        //   //! whopartnerupdated ...
        //   WhoPartnerUpdatedModel? whoPartnerUpdatedModel;
        //   if (ticket['whopartnerupdated'] != null) {
        //     var whoPartnerUpdated = Map<String, dynamic>.from(jsonDecode(ticket['whopartnerupdated']));

        //     whoPartnerUpdatedModel = WhoPartnerUpdatedModel(
        //         idProfile: int.parse(whoPartnerUpdated['idProfile'].toString()),
        //         fullname: whoPartnerUpdated['fullname'],
        //         email: whoPartnerUpdated['email'],
        //         phone: whoPartnerUpdated['phone'],
        //         userToken: whoPartnerUpdated['userToken'],
        //         typeUser: whoPartnerUpdated['typeUser'],
        //         typeRole: whoPartnerUpdated['typeRole']);
        //   }

        //   //! whocustomerupdated ...
        //   WhoCustomerUpdatedModel? whoCustomerUpdatedModel;
        //   if (ticket['whocustomerupdated'] != null) {
        //     var whoCustomerUpdated = Map<String, dynamic>.from(jsonDecode(ticket['whocustomerupdated']));

        //     whoCustomerUpdatedModel = WhoCustomerUpdatedModel(
        //         idProfile: int.parse(whoCustomerUpdated['idProfile'].toString()),
        //         fullname: whoCustomerUpdated['fullname'],
        //         email: whoCustomerUpdated['email'],
        //         phone: whoCustomerUpdated['phone'],
        //         userToken: whoCustomerUpdated['userToken'],
        //         typeUser: whoCustomerUpdated['typeUser'],
        //         typeRole: whoCustomerUpdated['typeRole']);
        //   }

        //   MaintenancesModel maintenancesModel = MaintenancesModel(
        //       id: int.parse(ticket['id'].toString()),
        //       fkTypeMaintenance: int.parse(ticket['fkTypeMaintenance'].toString()),
        //       fkPLC: (ticket['fkPLC'] != null) ? int.parse(ticket['fkPLC'].toString()) : null,
        //       fkCBO: int.parse(ticket['fkCBO'].toString()),
        //       fkStatusMaintenance: int.parse(ticket['fkStatusMaintenance'].toString()),
        //       fkCustomerProfileUpdated: (ticket['fkCustomerProfileUpdated'] != null) ? int.parse(ticket['fkCustomerProfileUpdated'].toString()) : null,
        //       customer: ticket['customer'],
        //       folio: int.parse(ticket['folio'].toString()),
        //       viewFolio: ticket['viewFolio'],
        //       description: ticket['description'],
        //       area: ticket['area'],
        //       reason: ticket['reason'],
        //       status: ticket['status'],
        //       type: ticket['type'],
        //       createdAt: DateTime.parse(ticket['createdAt'].toString()),
        //       statusUpdateAt: (ticket['statusUpdateAt'] != null) ? DateTime.parse(ticket['statusUpdateAt'].toString()) : null,
        //       branchOfficeModel: branchOfficeModel,
        //       photoevidence: photoEvidenceModel,
        //       whoPartnerCreatedModel: whoPartnerCreatedModel,
        //       whoCustomerCreatedModel: whoCustomerCreatedModel,
        //       whoPartnerUpdatedModel: whoPartnerUpdatedModel,
        //       whoCustomerUpdatedModel: whoCustomerUpdatedModel);

        //   maintenances.add(maintenancesModel);
        // }

        // return Either.right(maintenances);
      },
    );
  }
}
