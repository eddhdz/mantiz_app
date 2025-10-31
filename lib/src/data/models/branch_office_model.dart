import 'package:mantiz/src/data/models/ticket_model.dart';

class BranchOfficeModel {
  String branchofficeId;
  String branchoffice;
  String address;
  String latitude;
  String longitude;
  String clave;
  List<TicketModel> tickets;

  BranchOfficeModel({
    required this.branchofficeId,
    required this.branchoffice,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.clave,
    required this.tickets,
  });

  BranchOfficeModel.init()
      : branchofficeId = '',
        branchoffice = '',
        address = '',
        latitude = '',
        longitude = '',
        clave = '',
        tickets = [];

  // factory BranchOfficeModel.fromJson(Map<String, dynamic> json) {
  //   return BranchOfficeModel(
  //     branchofficeId: json['branchofficeId'],
  //     branchoffice: json['branchoffice'],
  //     address: json['address'],
  //     latitude: json['latitude'],
  //     longitude: json['longitude'],
  //     clave: json['clave'],
  //     tickets: TicketModel.fromJson(json['tickets']),
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'branchofficeId': branchofficeId,
  //       'branchoffice': branchoffice,
  //       'address': address,
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'clave': clave,
  //       'tickets': tickets.toJson(),
  //     };
}
