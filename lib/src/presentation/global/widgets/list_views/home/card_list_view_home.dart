part of 'list_view_home.dart';

Widget cardTicket(MaintenancesModel maintenance) {
  return Wrap(children: <Widget>[
    Column(children: <Widget>[
      GestureDetector(
        onTap: () {},
        child: SizedBox(
            child: Card(
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: blueExtraLightGlobalColor,
          child: Column(children: <Widget>[
            //! Folio ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  GeneralText(
                      mensaje: 'Folio:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter),
                  GeneralText(
                      mensaje: maintenance.viewFolio,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter),
                  const SizedBox(width: 5),
                ])),

            //! Título ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  GeneralText(
                      mensaje: 'Título:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter),
                  GeneralText(
                      mensaje: maintenance.description,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter),
                  const SizedBox(width: 5),
                ])),

            //! Cliente y estatus ...
            Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: <Widget>[
                  const SizedBox(width: 5),
                  GeneralText(
                      mensaje: 'Cliente:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter),
                  GeneralText(
                      mensaje: maintenance.customer,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter),
                  Expanded(child: Container()),
                  GeneralText(
                      mensaje: 'Estatus:',
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.bold,
                      color: blackPanter),
                  GeneralText(
                      mensaje: maintenance.status,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 14,
                      weight: FontWeight.normal,
                      color: blackPanter),
                  const SizedBox(width: 5),
                ])),
          ]),
        )),
      )
    ])
  ]);
}
