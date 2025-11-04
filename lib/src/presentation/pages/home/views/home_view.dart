//! Flutter ...
import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/home/views/home_view_vm.dart';

//! imports locales ...
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/initial_floating_button.dart';
import '../../../global/widgets/list_views/home/list_view_ticket.dart';
import '../../../global/widgets/texts/general_text.dart';

//! paquetes implementados ...
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final vmInit = Provider.of<HomeViewVm>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.loadMaintenances(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewVm>(context);
    Size screenSize = MediaQuery.of(context).size;

    final branchOffice = vm.selectedMaintenance?.branchoffices ?? [];

    return Scaffold(
      backgroundColor: whiteGlobalColor,
      appBar: AppBar(
          backgroundColor: whiteGlobalColor,
          title: const GeneralText(
              mensaje: 'Mantenimientos', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 17, weight: FontWeight.bold, color: blackPanter, align: TextAlign.center)),
      body: (vm.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: screenSize.height,
                child: Column(children: [
                  //! Combo de clientes (mtto) ...
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: vm.selectedMaintenance!.id.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Selecciona un cliente',
                      border: OutlineInputBorder(),
                    ),
                    items: vm.allMaintenances.map<DropdownMenuItem<String>>((c) {
                      return DropdownMenuItem<String>(
                        value: c.id.toString(),
                        child: Text(c.customer.toString().toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (String? idCustomer) {
                      if (idCustomer == null) return;

                      vm.selectMaintenanceById(context, idCustomer);
                    },
                  ),

                  //! Listado de sucursales ...
                  SizedBox(
                      height: screenSize.height * 0.75,
                      child: RefreshIndicator(
                          child: ListViewTicket(showBO: branchOffice),
                          onRefresh: () async {
                            // controller.text = '';
                            // await vm.loadAllTickets(context);
                          })),
                  const SizedBox(height: 10),
                  (vm.isLoading)
                      ? const SizedBox(height: 35, child: CircularProgressIndicator(backgroundColor: whiteGlobalColor, color: mediumDarkGray, strokeWidth: 4))
                      : Container(),

                  //! Lista agrupada por sucursal ...
                  // Expanded(
                  //     child: (branchOffice.isEmpty)
                  //         ? const Center(
                  //             child: Text('Selecciona un cliente para ver sus tickets'),
                  //           )
                  //         : ListViewHome(showBO: branchOffice))

                  //! filtro ...
                  // GeneralTextForm(
                  //     properties: GeneralTextPropertiesModel(
                  //         label: 'Palabra clave ...',
                  //         enable: true,
                  //         objectsColor: mediumGray,
                  //         textColor: blackPanter,
                  //         obscureText: false,
                  //         validator: null,
                  //         onChange: (value) async {
                  //           controller.text = value;

                  //           if (controller.text.isEmpty) {
                  //             await vm.loadMaintenances(context);
                  //           } else {
                  //             await vm.filterTickets(context, controller.text);
                  //           }
                  //         },
                  //         controller: controller,
                  //         keyboard: TextInputType.text,
                  //         minLines: 1,
                  //         maxLines: 1)),

                  //! lista de tickets ...
                  // const SizedBox(height: 10),
                  // (vm.visibleTickets.isEmpty)
                  //     ? const EmptyListView()
                  //     : SizedBox(
                  //         height: screenSize.height * 0.75,
                  //         child: RefreshIndicator(
                  //             child: ListViewHome(showTickets: vm.visibleTickets),
                  //             onRefresh: () async {
                  //               controller.text = '';

                  //               await vm.loadAllTickets(context);
                  //             })),
                  // const SizedBox(height: 10),
                  // (vm.isLoading)
                  //     ? const SizedBox(
                  //         height: 35,
                  //         child: CircularProgressIndicator(
                  //             backgroundColor: whiteGlobalColor,
                  //             color: mediumDarkGray,
                  //             strokeWidth: 4))
                  //     : Container(),
                ]),
              ),
            ),
      floatingActionButton: const InitialFloatingButton(),
    );
  }
}
