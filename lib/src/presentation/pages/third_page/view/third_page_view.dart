import 'package:flutter/material.dart';

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
                    ]),
                  ));
            },
          )),
      floatingActionButton: const InitialFloatingButton(),
    );
  }
}
