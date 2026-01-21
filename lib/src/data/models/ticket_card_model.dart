import 'package:mantiz/src/data/models/ticket_model.dart';

class TicketCardModel {
  int idCustomer;
  String customer;
  int idBO;
  String branchofficeId;
  String branchOffice;
  String address;
  String latitude;
  String longitude;
  String clave;
  TicketModel ticket;

  TicketCardModel({
    required this.idCustomer,
    required this.customer,
    required this.idBO,
    required this.branchofficeId,
    required this.branchOffice,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.clave,
    required this.ticket,
  });

  TicketCardModel.onInit()
      : idCustomer = 0,
        customer = '',
        idBO = 0,
        branchofficeId = '',
        branchOffice = '',
        address = '',
        latitude = '',
        longitude = '',
        clave = '',
        ticket = TicketModel.init();
}
