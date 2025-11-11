class SaveTicketModel {
  final int ticketId;
  final int fkTypeMaintenance;
  final String fkCBO;
  final int fkTypeStatusMaintenance;
  final String fkZone;
  final String folio;
  final String title;
  final String reason;
  final String photo;
  final DateTime createdat;
  final int createdby;
  String useruuid;
  final String devicefailuresids;

  SaveTicketModel(
      {required this.ticketId,
      required this.fkTypeMaintenance,
      required this.fkCBO,
      required this.fkTypeStatusMaintenance,
      required this.fkZone,
      required this.folio,
      required this.title,
      required this.reason,
      required this.photo,
      required this.createdat,
      required this.createdby,
      required this.useruuid,
      required this.devicefailuresids});

  SaveTicketModel.onInit()
      : ticketId = 0,
        fkTypeMaintenance = 0,
        fkCBO = '',
        fkTypeStatusMaintenance = 0,
        fkZone = '',
        folio = '',
        title = '',
        reason = '',
        photo = '',
        createdat = DateTime.now(),
        createdby = 0,
        useruuid = '',
        devicefailuresids = '';
}
