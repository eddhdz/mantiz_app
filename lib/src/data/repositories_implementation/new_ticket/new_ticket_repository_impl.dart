import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../models/branch_office_model.dart';
import '../../models/customer_model.dart';
import '../../models/device_model.dart';
import '../../../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../../models/failure_model.dart';
import '../../models/photo_evidence_model.dart';
import '../../models/save_photo_model.dart';
import '../../models/save_ticket_model.dart';
import '../../models/zone_model.dart';
import '../../services/remote/new_ticket/new_ticket_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewTicketRepositoryImpl implements NewTicketRepository {
  final FlutterSecureStorage _storage;
  final NewTicketApi _newTicketApi;

  NewTicketRepositoryImpl(this._newTicketApi, this._storage);

  @override
  Future<Either<GeneralFailure, PhotoEvidenceModel>> savePhoto(SavePhotoModel photo) async {
    final saveResult = await _newTicketApi.savePhoto(photo);

    var a = 1000;

    return saveResult.when((failure) {
      return Either.left(failure);
    }, (save) {
      final json = Map<String, dynamic>.from(jsonDecode(save));

      PhotoEvidenceModel photo = PhotoEvidenceModel.onInit();
      for (var item in json['list'] as List) {
        photo = PhotoEvidenceModel(
          uuid: item['uuid'],
          uuidapp: item['uuidapp'],
          name: item['name'],
          type: item['type'],
          url: item['url'],
        );
      }

      return Either.right(photo);
    });
  }

  @override
  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel ticket) async {
    String? useruuid = await _storage.read(key: 'useruuid');
    if (useruuid == null || useruuid.isEmpty) {
      return Either.left(GeneralFailure.noData);
    }

    ticket.useruuid = useruuid;

    final saveResult = await _newTicketApi.saveTicket(ticket);

    return saveResult.when((failure) {
      return Either.left(failure);
    }, (save) {
      return Either.right(save);
    });
  }

  @override
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers() async {
    String? userUuid = await _storage.read(key: 'useruuid');

    final newResult = await _newTicketApi.loadCustomers(userUuid);

    return newResult.when(
      (failure) {
        return Either.left(failure);
      },
      (responseCustomers) {
        List<CustomerModel> listCustomers = [];
        List<BranchOfficeModel> listBranchOffices = [];
        List<ZoneModel> listZones = [];
        List<DeviceModel> listDevices = [];
        List<FailureModel> listFailures = [];

        final json = Map<String, dynamic>.from(jsonDecode(responseCustomers));

        listCustomers = [];
        CustomerModel customerModel = CustomerModel.onInit();
        for (var list in json['list'] as List) {
          listBranchOffices = [];
          BranchOfficeModel branchOfficeModel = BranchOfficeModel.init();
          for (var branch in list['branchoffices'] as List) {
            listZones = [];
            ZoneModel zoneModel = ZoneModel.onInit();
            for (var zone in branch['zones'] as List) {
              listDevices = [];
              DeviceModel deviceModel = DeviceModel.init();
              for (var device in zone['devices'] as List) {
                listFailures = [];
                FailureModel failureModel = FailureModel.onInit();
                for (var failure in device['failures'] as List) {
                  failureModel = FailureModel(id: int.parse(failure['id'].toString()), description: failure['description']);

                  //! Failures ...
                  listFailures.add(failureModel);
                }

                deviceModel = DeviceModel(
                    deviceId: device['deviceId'].toString(),
                    name: device['name'],
                    code: device['code'],
                    barcode: device['barcode'] ?? '',
                    typedevice: (device['typedevice'] ?? ''),
                    priority: device['priority'] ?? '',
                    levelpriority: device['levelpriority'] ?? '',
                    rating: device['rating'] ?? 0,
                    failures: listFailures);

                //! Devices ...
                listDevices.add(deviceModel);
              }

              zoneModel = ZoneModel(zone: zone['zone'], devices: listDevices, zoneId: zone['zoneId']);

              //! zones ...
              listZones.add(zoneModel);
            }

            branchOfficeModel = BranchOfficeModel(
                boId: int.parse(branch['branchofficeId'].toString()),
                branchofficeId: branch['uuidBO'].toString(),
                branchoffice: branch['branchoffice'],
                address: branch['address'],
                latitude: branch['latitude'],
                longitude: branch['longitude'],
                clave: branch['clave'],
                tickets: [],
                zones: listZones);

            //! branchoffices ...
            listBranchOffices.add(branchOfficeModel);
          }

          customerModel = CustomerModel(customer: list['customer'], branchoffices: listBranchOffices);

          //! Customers ...
          listCustomers.add(customerModel);
        }

        return Either.right(listCustomers);
      },
    );
  }
}
