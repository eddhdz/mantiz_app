import 'package:flutter/material.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/models/ticket_model.dart';
import '../../../colors.dart';
import '../../texts/general_text.dart';

part 'card_list_view_home.dart';

class ListViewTicket extends StatelessWidget {
  final List<BranchOfficeModel> showBO;

  const ListViewTicket({super.key, required this.showBO});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: showBO.length,
        itemBuilder: (BuildContext context, int index) {
          return Container();

          // final branch = showBO[index];
          // final tickets = branch.tickets;

          // return Wrap(children: <Widget>[
          //   Column(children: <Widget>[SizedBox(child: cardTicket(showTickets[index], context))])
          // ]);

          // return Padding(
          //   padding: const EdgeInsets.only(bottom: 15, top: 15),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       //! Encabezado de sucursal
          //       GeneralText(
          //         mensaje: 'Sucursal: ${branch.branchoffice}',
          //         maxLines: 1,
          //         overFlow: TextOverflow.ellipsis,
          //         size: 16,
          //         weight: FontWeight.bold,
          //         color: blackPanter,
          //         align: TextAlign.start,
          //       ),

          //       const SizedBox(height: 5),

          //       //! Listado de tickets ...
          //       ...tickets.map<Widget>((ticket) {
          //         return Padding(padding: const EdgeInsets.only(left: 0, right: 0), child: cardTicket(ticket, context));
          //       }),

          //       const SizedBox(height: 300),
          //     ],
          //   ),
          // );
        });
  }
}
