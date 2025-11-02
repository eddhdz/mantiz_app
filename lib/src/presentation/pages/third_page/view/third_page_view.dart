import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/customs/custom_asign_to.dart';

import '../../../../data/models/ticket_model.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/initial_floating_button.dart';
import '../../../global/widgets/texts/general_text.dart';

class ThirdPageView extends StatelessWidget {
  final List<TicketModel> tickets;

  const ThirdPageView({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          backgroundColor: whiteGlobalColor,
          title: const GeneralText(
            mensaje: 'Tickets',
            maxLines: 1,
            overFlow: TextOverflow.ellipsis,
            size: 17,
            weight: FontWeight.bold,
            color: blackPanter,
            align: TextAlign.center,
          )),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: screenSize.height,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: tickets.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPageView(branchOffices: maintenances[index].branchoffices)));
                  },
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: veryLightGray,
                    child: Column(children: <Widget>[
                      Row(children: [
                        //! Id ...
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: <Widget>[
                              const SizedBox(width: 5),
                              const GeneralText(
                                  mensaje: 'Id:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                              GeneralText(
                                  mensaje: tickets[index].ticketId.toString(),
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 14,
                                  weight: FontWeight.normal,
                                  color: blackPanter,
                                  align: TextAlign.left),
                              const SizedBox(width: 5),
                            ])),

                        Expanded(child: Container()),
                        //! Folio ...
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: <Widget>[
                              const SizedBox(width: 5),
                              const GeneralText(
                                  mensaje: 'Folio:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                              GeneralText(
                                  mensaje: tickets[index].folio,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 14,
                                  weight: FontWeight.normal,
                                  color: blackPanter,
                                  align: TextAlign.right),
                              const SizedBox(width: 5),
                            ]))
                      ]),

                      //! Título ...
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: <Widget>[
                            const SizedBox(width: 5),
                            const GeneralText(
                                mensaje: 'Título:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                            Expanded(
                                child: GeneralText(
                                    mensaje: tickets[index].title!,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    size: 14,
                                    weight: FontWeight.normal,
                                    color: blackPanter,
                                    align: TextAlign.left)),
                            const SizedBox(width: 5),
                          ])),

                      Row(children: [
                        //! Type ...
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: <Widget>[
                              const SizedBox(width: 5),
                              const GeneralText(
                                  mensaje: 'Tipo:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                              GeneralText(
                                  mensaje: tickets[index].type,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 14,
                                  weight: FontWeight.normal,
                                  color: blackPanter,
                                  align: TextAlign.left),
                              const SizedBox(width: 5),
                            ])),

                        Expanded(child: Container()),
                        //! Area ...
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: <Widget>[
                              const SizedBox(width: 5),
                              const GeneralText(
                                  mensaje: 'Area:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                              GeneralText(
                                  mensaje: tickets[index].area,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 14,
                                  weight: FontWeight.normal,
                                  color: blackPanter,
                                  align: TextAlign.right),
                              const SizedBox(width: 5),
                            ]))
                      ]),

                      Row(children: [
                        //! Estatus ...
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(children: <Widget>[
                              const SizedBox(width: 5),
                              const GeneralText(
                                  mensaje: 'Estatus:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                              GeneralText(
                                  mensaje: tickets[index].status,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 14,
                                  weight: FontWeight.bold,
                                  color: (tickets[index].status.toLowerCase() == 'actualizado' ||
                                          tickets[index].status.toLowerCase() == 'abierto' ||
                                          tickets[index].status.toLowerCase() == 'asignado' ||
                                          tickets[index].status.toLowerCase() == 'aprobado' ||
                                          tickets[index].status.toLowerCase() == 'agendado')
                                      ? orangePrincipal
                                      : (tickets[index].status.toLowerCase() == 'suspendido' ||
                                              tickets[index].status.toLowerCase() == 'cancelado' ||
                                              tickets[index].status.toLowerCase() == 'rechazado')
                                          ? redPrincipal
                                          : (tickets[index].status.toLowerCase() == 'rechazado' || tickets[index].status.toLowerCase() == 'creado')
                                              ? blueLightGlobalColor
                                              : (tickets[index].status.toLowerCase() == 'finalizado')
                                                  ? greenPrincipal
                                                  : blackPanter,
                                  align: TextAlign.left),
                              const SizedBox(width: 5),
                            ])),

                        Expanded(child: Container()),

                        IconButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAsignTo(user: tickets[index].attendance.asignedto);
                                });
                          },
                          icon: const Icon(Icons.account_circle_outlined, size: 35),
                        )
                      ])
                    ]),
                  ));
            },
          )),
      floatingActionButton: const InitialFloatingButton(),
    );
  }
}
