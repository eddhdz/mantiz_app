//! Flutter ...
import 'package:flutter/material.dart';

//! imports locales ...
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/initial_floating_button.dart';
import '../../../global/widgets/list_views/home/list_view_home.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../../global/widgets/texts/general_text_form.dart';

//! paquetes implementados ...

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onFilterChange(String value) {}

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          title: GeneralText(
              mensaje: 'Servicios',
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              size: 17,
              weight: FontWeight.bold,
              color: blackPanter)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: screenSize.height,
        child: Column(children: [
          //! filtro ...
          const SizedBox(height: 15),
          GeneralTextForm(
              label: 'Palabra clave ...',
              enable: true,
              objectsColor: blueNeutralGlobalColor,
              textColor: blackPanter,
              validator: null,
              onChange: (value) => _onFilterChange(value)),

          //! lista de tickets ...
          const SizedBox(height: 10),
          const Expanded(child: SizedBox(child: ListViewHome())),
          const SizedBox(height: 200)
        ]),
      ),
      floatingActionButton: const InitialFloatingButton(),
    );
  }
}
