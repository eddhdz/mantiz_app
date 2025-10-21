import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../models/branch_office_model.dart';
import '../../models/customer_model.dart';
import '../../models/device_model.dart';
import '../../../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../../models/photo_evidence_model.dart';
import '../../models/save_photo_model.dart';
import '../../models/save_ticket_model.dart';
import '../../services/remote/new_ticket/new_ticket_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewTicketRepositoryImpl implements NewTicketRepository {
  final FlutterSecureStorage _storage;
  final NewTicketApi _newTicketApi;

  NewTicketRepositoryImpl(this._newTicketApi, this._storage);

  @override
  Future<Either<GeneralFailure, PhotoEvidenceModel>> savePhoto(SavePhotoModel photo) async {
    final saveResult = await _newTicketApi.savePhoto(photo);

    return saveResult.when((failure) {
      return Either.left(failure);
    }, (save) {
      PhotoEvidenceModel photo = PhotoEvidenceModel.onInit();

      final json = Map<String, dynamic>.from(jsonDecode(save));
      if (json['response']['id'] > 0) {
        if ((json['list'] as List).isNotEmpty) {
          photo = PhotoEvidenceModel(
            uuid: json['list'][0]['uuid'],
            uuidapp: json['list'][0]['uuidapp'],
            name: json['list'][0]['name'],
            type: json['list'][0]['type'],
            url: json['list'][0]['url'],
          );
        } else {
          return Either.left(GeneralFailure.clientError);
        }
      } else {
        return Either.left(GeneralFailure.clientError);
      }

      return Either.right(photo);
    });
  }

  @override
  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel ticket) async {
    final allStorage = await _storage.readAll();

    //! En este punto nos falta saber si el ticket fue creado por un <Partner> o un <customer> ...
    List<String> keys = ['Partner', 'Supplier', 'Customer'];
    String? target;
    int? valor;

    for (var key in keys) {
      if (allStorage.containsKey(key)) {
        target = key;
        valor = int.parse(allStorage[target].toString());

        break;
      }
    }

    if (target == 'Partner') {
      ticket.createdByPartner = valor;
    } else if (target == 'Customer') {
      ticket.createdByCustomer = valor;
    } else {
      return Either.right(false);
    }

    final saveResult = await _newTicketApi.saveTicket(ticket);

    return saveResult.when((failure) {
      return Either.left(failure);
    }, (save) {
      return Either.right(save);
    });
  }

  @override
  Future<Either<GeneralFailure, List<DeviceModel>>> loadDevices(int fkCBO) async {
    final deviceResult = await _newTicketApi.loadDevices(fkCBO);

    return deviceResult.when(
      (failure) {
        return Either.left(failure);
      },
      (responseDevices) {
        List<DeviceModel> devices = [];

        final json = Map<String, dynamic>.from(jsonDecode(responseDevices));

        for (var item in json['devices'] as List) {
          Map<String, dynamic> device = Map<String, dynamic>.from(jsonDecode(item['device']));

          DeviceModel deviceModel = DeviceModel(
              id: int.parse(item['id'].toString()),
              code: item['code'],
              uuidDevice: device['uuidDevice'],
              description: device['description'],
              barCode: device['barcode'],
              specs: device['specs'],
              subCategory: device['subcategory'],
              category: device['category'],
              product: device['product'],
              typeService: device['typeservice'],
              brand: device['brand']);

          devices.add(deviceModel);
        }

        return Either.right(devices);
      },
    );
  }

  @override
  Future<Either<GeneralFailure, List<BranchOfficeModel>>> loadBranchs(int fkCustomer) async {
    final branchResult = await _newTicketApi.loadBranchs(fkCustomer);

    return branchResult.when(
      (failure) {
        return Either.left(failure);
      },
      (responseBranch) {
        List<BranchOfficeModel> branchs = [];

        final json = Map<String, dynamic>.from(jsonDecode(responseBranch));

        for (var item in json['branchoffices'] as List) {
          Map<String, dynamic> branchOffice = Map<String, dynamic>.from(jsonDecode(item['branchoffice']));

          BranchOfficeModel branchOfficeModel = BranchOfficeModel(
              id: int.parse(item['id'].toString()),
              fkSubcompany: int.parse(branchOffice['fkSubcompany'].toString()),
              description: branchOffice['description'],
              location: branchOffice['location'],
              latitud: branchOffice['latitud'],
              longitud: branchOffice['longitud'],
              imagen: branchOffice['imagen'],
              clave: branchOffice['clave'],
              subcompany: branchOffice['subcompany'],
              uuidBO: item['uuidBO']);

          branchs.add(branchOfficeModel);
        }

        return Either.right(branchs);
      },
    );
  }

  @override
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers() async {
    final partner = await _storage.read(key: 'fkPartnerLicence');

    final newResult = await _newTicketApi.loadCustomers(int.parse(partner!));

    return newResult.when(
      (failure) {
        return Either.left(failure);
      },
      (responseCustomers) {
        List<CustomerModel> customers = [];

        final json = Map<String, dynamic>.from(jsonDecode(responseCustomers));

        for (var item in json['customers'] as List) {
          CustomerModel customerModel = CustomerModel(
              id: int.parse(item['id'].toString()),
              fkPartner: int.parse(item['fkPartner'].toString()),
              partner: item['partner'],
              fkCustomer: int.parse(item['fkCustomer'].toString()),
              customer: item['customer']);

          customers.add(customerModel);
        }

        return Either.right(customers);
      },
    );
  }
}
