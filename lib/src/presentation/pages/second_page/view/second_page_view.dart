import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../third_page/view/third_page_view.dart';

class SecondPageView extends StatelessWidget {
  final List<BranchOfficeModel> branchOffices;

  const SecondPageView({super.key, required this.branchOffices});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          backgroundColor: whiteGlobalColor,
          title: const GeneralText(
            mensaje: 'Sucursales',
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
            itemCount: branchOffices.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ThirdPageView(tickets: branchOffices[index].tickets)));
                  },
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: veryLightGray,
                    child: Column(children: <Widget>[
                      //! Clave ...
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: <Widget>[
                            const SizedBox(width: 5),
                            const GeneralText(
                                mensaje: 'Clave:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                            GeneralText(
                                mensaje: branchOffices[index].clave,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                                size: 14,
                                weight: FontWeight.normal,
                                color: blackPanter,
                                align: TextAlign.left),
                            const SizedBox(width: 5),
                          ])),

                      //! branch id ...
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: <Widget>[
                            const SizedBox(width: 5),
                            const GeneralText(
                                mensaje: 'Cliente:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                            Expanded(
                                child: GeneralText(
                                    mensaje: branchOffices[index].branchofficeId,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    size: 14,
                                    weight: FontWeight.normal,
                                    color: blackPanter,
                                    align: TextAlign.left)),
                            const SizedBox(width: 5),
                          ])),

                      //! branch name ...
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: <Widget>[
                            const SizedBox(width: 5),
                            const GeneralText(
                                mensaje: 'Nombre:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 14, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left),
                            Expanded(
                                child: GeneralText(
                                    mensaje: branchOffices[index].branchoffice,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    size: 14,
                                    weight: FontWeight.normal,
                                    color: blackPanter,
                                    align: TextAlign.left)),
                            const SizedBox(width: 5),
                          ])),
                    ]),
                  ));
            },
          )),
    );
  }
}
