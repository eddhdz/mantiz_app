import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/customs/custom_asign_to.dart';
import 'package:mantiz/src/presentation/pages/third_page/controller/third_page_controller.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/ticket_model.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/initial_floating_button.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../../routes/routes.dart';
import '../../starting_point.dart/controller/starting_point_controller.dart';

class ThirdPageView extends StatefulWidget {
  final List<TicketModel> tickets;

  const ThirdPageView({super.key, required this.tickets});

  @override
  State<ThirdPageView> createState() => _ThirdPageViewState();
}

class _ThirdPageViewState extends State<ThirdPageView> {
  final TextEditingController _filterController = TextEditingController();
  late ThirdPageController _controller;

  void onFilterChange() {
    setState(() {
      _controller.applyFilter(_filterController.text);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = ThirdPageController(widget.tickets);
    _filterController.addListener(onFilterChange);
  }

  @override
  void dispose() {
    _filterController.removeListener(onFilterChange);
    _filterController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ChangeNotifierProvider<ThirdPageController>.value(
        value: _controller,
        child: Consumer<ThirdPageController>(builder: (context, vm, _) {
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
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextField(
                      controller: _filterController,
                      decoration: InputDecoration(
                        hintText:
                            'Buscar por id, folio, título, tipo, área, estatus...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _filterController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _filterController.clear();
                                  _controller.resetFilter();
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                )),
            body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: screenSize.height,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: vm.visibleTickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ticket = vm.visibleTickets[index];

                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.detailTicket,
                            arguments: widget.tickets[index],
                          );
                        },
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: veryLightGray,
                          child: Column(children: <Widget>[
                            Row(children: [
                              //! Id ...
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: <Widget>[
                                    const SizedBox(width: 5),
                                    const GeneralText(
                                        mensaje: 'Id:',
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    GeneralText(
                                        mensaje: ticket.ticketId.toString(),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: <Widget>[
                                    const SizedBox(width: 5),
                                    const GeneralText(
                                        mensaje: 'Folio:',
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    GeneralText(
                                        mensaje: ticket.folio,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.normal,
                                        color: blackPanter,
                                        align: TextAlign.right),
                                    const SizedBox(width: 5),
                                  ]))
                            ]),

                            //! Título ...
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(children: <Widget>[
                                  const SizedBox(width: 5),
                                  const GeneralText(
                                      mensaje: 'Título:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 14,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left),
                                  Expanded(
                                      child: GeneralText(
                                          mensaje: ticket.title!,
                                          maxLines: 1,
                                          overFlow: TextOverflow.ellipsis,
                                          size: 14,
                                          weight: FontWeight.normal,
                                          color: blackPanter,
                                          align: TextAlign.left)),
                                  const SizedBox(width: 5),
                                ])),

                            Row(children: [
                              //! Type ...
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: <Widget>[
                                    const SizedBox(width: 5),
                                    const GeneralText(
                                        mensaje: 'Tipo:',
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    GeneralText(
                                        mensaje: ticket.type,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.normal,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    const SizedBox(width: 5),
                                  ])),

                              Expanded(child: Container()),
                              //! Area ...
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: <Widget>[
                                    const SizedBox(width: 5),
                                    const GeneralText(
                                        mensaje: 'Area:',
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    GeneralText(
                                        mensaje: ticket.area,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.normal,
                                        color: blackPanter,
                                        align: TextAlign.right),
                                    const SizedBox(width: 5),
                                  ]))
                            ]),

                            Row(children: [
                              //! Estatus ...
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(children: <Widget>[
                                    const SizedBox(width: 5),
                                    const GeneralText(
                                        mensaje: 'Estatus:',
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: blackPanter,
                                        align: TextAlign.left),
                                    GeneralText(
                                        mensaje: ticket.status,
                                        maxLines: 1,
                                        overFlow: TextOverflow.ellipsis,
                                        size: 14,
                                        weight: FontWeight.bold,
                                        color: (ticket.status
                                                        .toLowerCase() ==
                                                    'actualizado' ||
                                                ticket.status
                                                        .toLowerCase() ==
                                                    'abierto' ||
                                                ticket
                                                        .status
                                                        .toLowerCase() ==
                                                    'asignado' ||
                                                ticket
                                                        .status
                                                        .toLowerCase() ==
                                                    'aprobado' ||
                                                ticket
                                                        .status
                                                        .toLowerCase() ==
                                                    'agendado')
                                            ? orangePrincipal
                                            : (ticket
                                                            .status
                                                            .toLowerCase() ==
                                                        'suspendido' ||
                                                    ticket.status
                                                            .toLowerCase() ==
                                                        'cancelado' ||
                                                    ticket.status
                                                            .toLowerCase() ==
                                                        'rechazado')
                                                ? redPrincipal
                                                : (ticket.status.toLowerCase() ==
                                                            'rechazado' ||
                                                        ticket.status
                                                                .toLowerCase() ==
                                                            'creado')
                                                    ? blueLightGlobalColor
                                                    : (ticket.status
                                                                .toLowerCase() ==
                                                            'finalizado')
                                                        ? greenPrincipal
                                                        : blackPanter,
                                        align: TextAlign.left),
                                    const SizedBox(width: 5),
                                  ])),

                              Expanded(child: Container()),

                              IconButton(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAsignTo(
                                            user: widget.tickets[index]
                                                .attendance.asignedto);
                                      });
                                },
                                icon: const Icon(Icons.account_circle_outlined,
                                    size: 35),
                              )
                            ])
                          ]),
                        ));
                  },
                )),
            floatingActionButton: const InitialFloatingButton(),
          );
        }));
  }
}
