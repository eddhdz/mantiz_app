//! Flutter ...
import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/home/views/home_view_vm.dart';

//! imports locales ...
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/initial_floating_button.dart';
import '../../../global/widgets/list_views/home/empty_list_view.dart';
import '../../../global/widgets/list_views/home/list_view_home.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../../global/widgets/texts/general_text_form.dart';

//! paquetes implementados ...
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final vmInit = Provider.of<HomeViewVm>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.loadAllTickets(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewVm>(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          title: const GeneralText(
              mensaje: 'Servicios',
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              size: 17,
              weight: FontWeight.bold,
              color: blackPanter)),
      body: SingleChildScrollView(
        child: Container(
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
                obscureText: false,
                controller: controller,
                validator: null,
                onChange: (value) async {
                  controller.text = value;
                  if (controller.text.isEmpty) {
                    await vm.loadAllTickets(context);
                  } else {
                    await vm.filterTickets(context, controller.text);
                  }
                }),

            //! lista de tickets ...
            const SizedBox(height: 10),
            (vm.visibleTickets.isEmpty)
                ? const EmptyListView()
                : SizedBox(
                    height: screenSize.height * 0.75,
                    child: RefreshIndicator(
                        child: ListViewHome(showTickets: vm.visibleTickets),
                        onRefresh: () async {
                          controller.text = '';

                          await vm.loadAllTickets(context);
                        })),
            const SizedBox(height: 10),
            (vm.isLoading)
                ? const SizedBox(
                    height: 35,
                    child: CircularProgressIndicator(
                        backgroundColor: whiteGlobalColor,
                        color: blueNeutralGlobalColor,
                        strokeWidth: 4))
                : Container(),
          ]),
        ),
      ),
      floatingActionButton: const InitialFloatingButton(),
    );
  }
}
