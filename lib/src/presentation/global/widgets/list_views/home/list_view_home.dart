import 'package:flutter/material.dart';

import '../../../../../data/models/models.dart';
import '../../../colors.dart';
import '../../texts/general_text.dart';

part 'card_list_view_home.dart';

class ListViewHome extends StatelessWidget {
  final List<MaintenancesModel> showTickets;

  const ListViewHome({super.key, required this.showTickets});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: showTickets.length,
        itemBuilder: (BuildContext context, int index) {
          return Wrap(children: <Widget>[
            Column(children: <Widget>[
              SizedBox(child: cardTicket(showTickets[index]))
            ])
          ]);
        });
  }
}
