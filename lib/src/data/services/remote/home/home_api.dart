import 'dart:convert';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/models.dart';
import '../../../http/http.dart';

class HomeApi {
  final Http _http;

  HomeApi(this._http);

  Future<Either<GeneralFailure, List<MaintenancesModel>>>
      loadMaintenances() async {
    final result = await _http.request('/api/mantiz/v1/mysql/tickets',
        method: HttpMethod.post, body: {'id': '0'});

    return result.when((failure) {
      if (failure.statusCode == null) {
        return Either.left(GeneralFailure.noData);
      } else if (failure.exception is NetworkException) {
        return Either.left(GeneralFailure.network);
      } else if (failure.statusCode! >= 400 && failure.statusCode! <= 499) {
        return Either.left(GeneralFailure.clientError);
      } else if (failure.statusCode! >= 500 && failure.statusCode! <= 599) {
        return Either.left(GeneralFailure.serverError);
      } else {
        return Either.left(GeneralFailure.unknown);
      }
    }, (responseBody) {
      List<MaintenancesModel> maintenances = [];

      final json = Map<String, dynamic>.from(jsonDecode(responseBody));

      for (var ticket in json['maintenances'] as List) {
        //! branchoffice ...
        var branchOffice =
            Map<String, dynamic>.from(jsonDecode(ticket['branchoffice']));
        BranchOfficeModel branchOfficeModel = BranchOfficeModel(
            id: int.parse(branchOffice['id'].toString()),
            fkSubcompany: int.parse(branchOffice['fkSubcompany'].toString()),
            description: branchOffice['description'],
            location: branchOffice['location'],
            latitud: branchOffice['latitud'],
            longitud: branchOffice['longitud'],
            imagen: branchOffice['imagen'],
            clave: branchOffice['clave'],
            subcompany: branchOffice['subcompany'],
            uuidBO: branchOffice['uuidBO']);

        //! whopartnercreated ...
        WhoPartnerCreatedModel? whoPartnerCreatedModel;
        if (ticket['whopartnercreated'] != null) {
          var whoPartnerCreated = Map<String, dynamic>.from(
              jsonDecode(ticket['whopartnercreated']));

          whoPartnerCreatedModel = WhoPartnerCreatedModel(
              idProfile: int.parse(whoPartnerCreated['idProfile'].toString()),
              fullname: whoPartnerCreated['fullname'],
              email: whoPartnerCreated['email'],
              phone: whoPartnerCreated['phone'],
              userToken: whoPartnerCreated['userToken'],
              typeUser: whoPartnerCreated['typeUser'],
              typeRole: whoPartnerCreated['typeRole']);
        }

        //! whocustomercreated ...
        WhoCustomerCreatedModel? whoCustomerCreatedModel;
        if (ticket['whocustomercreated'] != null) {
          var whoCustomerCreated = Map<String, dynamic>.from(
              jsonDecode(ticket['whocustomercreated']));

          whoCustomerCreatedModel = WhoCustomerCreatedModel(
              idProfile: int.parse(whoCustomerCreated['idProfile'].toString()),
              fullname: whoCustomerCreated['fullname'],
              email: whoCustomerCreated['email'],
              phone: whoCustomerCreated['phone'],
              userToken: whoCustomerCreated['userToken'],
              typeUser: whoCustomerCreated['typeUser'],
              typeRole: whoCustomerCreated['typeRole']);
        }

        //! whopartnerupdated ...
        WhoPartnerUpdatedModel? whoPartnerUpdatedModel;
        if (ticket['whopartnerupdated'] != null) {
          var whoPartnerUpdated = Map<String, dynamic>.from(
              jsonDecode(ticket['whopartnerupdated']));

          whoPartnerUpdatedModel = WhoPartnerUpdatedModel(
              idProfile: int.parse(whoPartnerUpdated['idProfile'].toString()),
              fullname: whoPartnerUpdated['fullname'],
              email: whoPartnerUpdated['email'],
              phone: whoPartnerUpdated['phone'],
              userToken: whoPartnerUpdated['userToken'],
              typeUser: whoPartnerUpdated['typeUser'],
              typeRole: whoPartnerUpdated['typeRole']);
        }

        //! whocustomerupdated ...
        WhoCustomerUpdatedModel? whoCustomerUpdatedModel;
        if (ticket['whocustomerupdated'] != null) {
          var whoCustomerUpdated = Map<String, dynamic>.from(
              jsonDecode(ticket['whocustomerupdated']));

          whoCustomerUpdatedModel = WhoCustomerUpdatedModel(
              idProfile: int.parse(whoCustomerUpdated['idProfile'].toString()),
              fullname: whoCustomerUpdated['fullname'],
              email: whoCustomerUpdated['email'],
              phone: whoCustomerUpdated['phone'],
              userToken: whoCustomerUpdated['userToken'],
              typeUser: whoCustomerUpdated['typeUser'],
              typeRole: whoCustomerUpdated['typeRole']);
        }

        MaintenancesModel maintenancesModel = MaintenancesModel(
            id: int.parse(ticket['id'].toString()),
            fkTypeMaintenance:
                int.parse(ticket['fkTypeMaintenance'].toString()),
            fkPLC: (ticket['fkPLC'] != null)
                ? int.parse(ticket['fkPLC'].toString())
                : null,
            fkCBO: int.parse(ticket['fkCBO'].toString()),
            fkStatusMaintenance:
                int.parse(ticket['fkStatusMaintenance'].toString()),
            customer: ticket['customer'],
            folio: int.parse(ticket['folio'].toString()),
            viewFolio: ticket['viewFolio'],
            description: ticket['description'],
            area: ticket['area'],
            reason: ticket['reason'],
            photoevidence: (ticket['photoevidence'] != null)
                ? ticket['photoevidence']
                : null,
            status: ticket['status'],
            type: ticket['type'],
            createdAt: DateTime.parse(ticket['createdAt'].toString()),
            statusUpdateAt: (ticket['statusUpdateAt'] != null)
                ? DateTime.parse(ticket['statusUpdateAt'].toString())
                : null,
            branchOfficeModel: branchOfficeModel,
            whoPartnerCreatedModel: whoPartnerCreatedModel,
            whoCustomerCreatedModel: whoCustomerCreatedModel,
            whoPartnerUpdatedModel: whoPartnerUpdatedModel,
            whoCustomerUpdatedModel: whoCustomerUpdatedModel);

        maintenances.add(maintenancesModel);
      }

      return Either.right(maintenances);
    });
  }
}
