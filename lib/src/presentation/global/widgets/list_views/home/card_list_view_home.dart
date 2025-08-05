part of 'list_view_home.dart';

Widget cardTicket(MaintenancesModel maintenance, BuildContext context) {
  return Wrap(children: <Widget>[
    Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.detailTicket,
            arguments: maintenance,
          );
        },
        child: SizedBox(
            child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: veryLightGray,
          child: Column(children: <Widget>[
            //! Folio ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  const GeneralText(
                      mensaje: 'Folio:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter,
                      align: TextAlign.left),
                  GeneralText(
                      mensaje: maintenance.viewFolio.toString(),
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter,
                      align: TextAlign.left),
                  const SizedBox(width: 5),
                ])),

            //! Título ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  const GeneralText(
                      mensaje: 'Título:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter,
                      align: TextAlign.left),
                  GeneralText(
                      mensaje: maintenance.description,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter,
                      align: TextAlign.left),
                  const SizedBox(width: 5),
                ])),

            //! Cliente y estatus ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  const GeneralText(
                      mensaje: 'Cliente:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter,
                      align: TextAlign.left),
                  GeneralText(
                      mensaje: maintenance.customer,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter,
                      align: TextAlign.left),
                  Expanded(child: Container()),
                  const GeneralText(
                      mensaje: 'Estatus:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter,
                      align: TextAlign.left),
                  GeneralText(
                      mensaje: maintenance.status,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter,
                      align: TextAlign.left),
                  const SizedBox(width: 5),
                ])),
          ]),
        )),
      )
    ])
  ]);
}
