import 'package:mantiz/src/data/models/ticket_model.dart';
import 'package:mantiz/src/data/models/zone_model.dart';

class BranchOfficeModel {
  int boId;
  String branchofficeId;
  String branchoffice;
  String address;
  String latitude;
  String longitude;
  String clave;
  List<TicketModel> tickets;
  List<ZoneModel> zones;

  BranchOfficeModel(
      {required this.boId,
      required this.branchofficeId,
      required this.branchoffice,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.clave,
      required this.tickets,
      required this.zones});

  BranchOfficeModel.init()
      : boId = 0,
        branchofficeId = '',
        branchoffice = '',
        address = '',
        latitude = '',
        longitude = '',
        clave = '',
        tickets = [],
        zones = [];
}
