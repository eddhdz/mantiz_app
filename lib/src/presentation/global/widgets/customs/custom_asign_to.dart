import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/colors.dart';
import 'package:mantiz/src/presentation/global/widgets/texts/general_text.dart';

import '../../../../data/models/models.dart';

class CustomAsignTo extends StatelessWidget {
  final UserModel? user;

  const CustomAsignTo({super.key, required this.user});

  contentBox(context) {
    return Container(
      alignment: Alignment.center,
      height: 250,
      padding: const EdgeInsets.only(
        top: 0,
      ),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: whiteGlobalColor, borderRadius: BorderRadius.circular(15), boxShadow: const [
        BoxShadow(color: blackPanter, offset: Offset(0, 10), blurRadius: 10),
      ]),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const SizedBox(height: 10),

              //!
              const Icon(
                Icons.account_circle_outlined,
                size: 60,
                color: blueNeutralGlobalColor,
              ),

              //!! uuid ...
              const SizedBox(height: 10),
              Row(children: [
                const SizedBox(width: 5),
                const SizedBox(
                    child: GeneralText(
                  mensaje: 'Uuid:',
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 16,
                  weight: FontWeight.bold,
                  color: blackPanter,
                  align: TextAlign.center,
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: GeneralText(
                  mensaje: user!.useruuid,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 15,
                  weight: FontWeight.normal,
                  color: blackPanter,
                  align: TextAlign.start,
                )),
                const SizedBox(width: 5),
              ]),

              //! Nombre ...
              const SizedBox(height: 10),
              Row(children: [
                const SizedBox(width: 5),
                const SizedBox(
                    child: GeneralText(
                  mensaje: 'Nombre:',
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 16,
                  weight: FontWeight.bold,
                  color: blackPanter,
                  align: TextAlign.center,
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: GeneralText(
                  mensaje: user!.name,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 15,
                  weight: FontWeight.normal,
                  color: blackPanter,
                  align: TextAlign.start,
                )),
                const SizedBox(width: 5),
              ]),

              //! Email ...
              const SizedBox(height: 10),
              Row(children: [
                const SizedBox(width: 5),
                const SizedBox(
                    child: GeneralText(
                  mensaje: 'Email:',
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 16,
                  weight: FontWeight.bold,
                  color: blackPanter,
                  align: TextAlign.center,
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: GeneralText(
                  mensaje: user!.email,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 15,
                  weight: FontWeight.normal,
                  color: blackPanter,
                  align: TextAlign.start,
                )),
                const SizedBox(width: 5),
              ]),

              //! Teléfono ...
              const SizedBox(height: 10),
              Row(children: [
                const SizedBox(width: 5),
                const SizedBox(
                    child: GeneralText(
                  mensaje: 'Teléfono:',
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 16,
                  weight: FontWeight.bold,
                  color: blackPanter,
                  align: TextAlign.center,
                )),
                const SizedBox(width: 5),
                Expanded(
                    child: GeneralText(
                  mensaje: user!.phone,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  size: 15,
                  weight: FontWeight.normal,
                  color: blackPanter,
                  align: TextAlign.start,
                )),
                const SizedBox(width: 5),
              ]),
            ],
          )),
    );
  }

  contentEmpty(context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 200,
          padding: const EdgeInsets.only(
            top: 0,
          ),
          margin: const EdgeInsets.only(top: 55),
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: whiteGlobalColor, borderRadius: BorderRadius.circular(15), boxShadow: const [
            BoxShadow(color: blackPanter, offset: Offset(0, 10), blurRadius: 10),
          ]),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 1,
              ),
              Expanded(
                  child: Center(
                      child: GeneralText(
                mensaje: 'El ticket no tiene asignada una persona',
                maxLines: 3,
                overFlow: TextOverflow.ellipsis,
                size: 20,
                weight: FontWeight.normal,
                color: blackPanter,
                align: TextAlign.center,
              )))
            ],
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
      child: (user == null || user!.useruuid.isEmpty) ? contentEmpty(context) : contentBox(context),
    );
  }
}
