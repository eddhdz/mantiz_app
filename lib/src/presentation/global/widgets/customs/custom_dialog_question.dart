import 'package:flutter/material.dart';

import '../../colors.dart';
import '../texts/general_text.dart';

class CustomDialogQuestion extends StatelessWidget {
  final String descriptions, btnOk, btnNotOk, title;
  final double altura;

  const CustomDialogQuestion({
    super.key,
    required this.title,
    required this.descriptions,
    required this.btnOk,
    required this.btnNotOk,
    required this.altura,
  });

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: altura,
          padding: const EdgeInsets.only(left: 0, top: 55, right: 0, bottom: 0),
          margin: const EdgeInsets.only(top: 55),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: whiteGlobalColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: blackPanter, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  child: GeneralText(
                      mensaje: title,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      size: 20,
                      weight: FontWeight.bold,
                      color: blackPanter,
                      align: TextAlign.center)),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView(children: <Widget>[
                        SelectableText(descriptions.replaceAll('|', '\n'),
                            style: const TextStyle(
                                fontSize: 14, color: blackPanter),
                            textAlign: TextAlign.center)
                      ]))),
              const SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            blueLightGlobalColor,
                            blueLightGlobalColor
                          ])),
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    child: GeneralText(
                        mensaje: btnNotOk,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 16,
                        weight: FontWeight.bold,
                        color: whiteGlobalColor,
                        align: TextAlign.center),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                )),
                const SizedBox(width: 1),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            blueLightGlobalColor,
                            blueLightGlobalColor
                          ])),
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    child: GeneralText(
                        mensaje: btnOk,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 16,
                        weight: FontWeight.bold,
                        color: whiteGlobalColor,
                        align: TextAlign.center),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                )),
              ]),
              const SizedBox(height: 20)
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 55,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(55)),
                child: Image.asset('lib/src/assets/customs/cuestion@4x.png')),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
}
