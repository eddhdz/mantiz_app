import 'package:flutter/material.dart';

import '../../../../data/models/maintenances_model.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../second_page/view/second_page_view.dart';

class FirstPageView extends StatelessWidget {
  final List<MaintenancesModel> maintenances;

  const FirstPageView({super.key, required this.maintenances});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          backgroundColor: whiteGlobalColor,
          title: const GeneralText(
            mensaje: 'Mantenimientos',
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
          itemCount: maintenances.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPageView(branchOffices: maintenances[index].branchoffices)));
                },
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: veryLightGray,
                  child: Column(children: <Widget>[
                    //! Id ...
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(children: <Widget>[
                          const SizedBox(width: 5),
                          const GeneralText(
                              mensaje: 'Clave:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                          GeneralText(
                              mensaje: maintenances[index].id.toString(),
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              size: 14,
                              weight: FontWeight.normal,
                              color: blackPanter,
                              align: TextAlign.left),
                          const SizedBox(width: 5),
                        ])),

                    //! Customer ...
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(children: <Widget>[
                          const SizedBox(width: 5),
                          const GeneralText(
                              mensaje: 'Cliente:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                          GeneralText(
                              mensaje: maintenances[index].customer,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              size: 14,
                              weight: FontWeight.normal,
                              color: blackPanter,
                              align: TextAlign.left),
                          const SizedBox(width: 5),
                        ])),
                  ]),
                ));
          },
        ),
      ),
    );
  }
}
