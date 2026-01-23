import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantiz/src/data/models/ticket_detail/ticket_list_response_model.dart';
import 'package:mantiz/src/domain/providers/session/user_session_provider.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/detail_provider.dart';
import 'package:mantiz/src/presentation/global/colors.dart';

import '../../../../data/models/ticket_model.dart';

import '../../../../domain/enums.dart';
import '../../../global/widgets/speed_dials/speed_dial_detail_ticket.dart';
import '../../../routes/routes.dart';

import 'package:provider/provider.dart';

class DetailTicketView extends StatefulWidget {
  final TicketModel ticket;

  const DetailTicketView({super.key, required this.ticket});

  @override
  State<DetailTicketView> createState() => _DetailTicketViewState();
}

class _DetailTicketViewState extends State<DetailTicketView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailProvider>(context, listen: false)
          .fetchDetail(widget.ticket.ticketId);
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<AssignedToProvider>(context, listen: false).fetchAssignedTo(widget.maintenance.id.toString());
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<ScheduleForProvider>(context, listen: false).fetchScheduleFor(widget.maintenance.id);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<PrizedByProvider>(context, listen: false).fetchPrizedBy(widget.maintenance.id);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<SuspendedByProvider>(context, listen: false).fetchSuspendedBy(widget.maintenance.id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<UserSessionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Servicio #${widget.ticket.folio}"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: sidonSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.ticket.status,
                style: const TextStyle(fontSize: 15, color: sidonTextColor),
              ),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // const storage = FlutterSecureStorage();
                // String? fkPartnerLicence = await storage.read(key: 'fkPartnerLicence');
                // String? fkProfileCustomer = await storage.read(key: 'Customer');
                // String? fkProfileSupplier = await storage.read(key: 'Supplier');
                // String? fkProfilePartner = await storage.read(key: 'Partner');
                // String? currentFkProfile = fkProfileCustomer ?? fkProfileSupplier ?? fkProfilePartner;

                // if (currentFkProfile == null || fkPartnerLicence == null) {
                //   // ignore: use_build_context_synchronously
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Error: Información de usuario o licencia incompleta.')),
                //   );
                //   return; // Detiene la ejecución
                // }
                Navigator.pushNamed(
                    // ignore: use_build_context_synchronously
                    context,
                    Routes.trackingTicket,
                    arguments: [
                      widget.ticket.ticketId,
                      userSession.currentUser!.userId,
                      widget.ticket.folio,
                    ]);
              },
              icon: const Icon(
                Icons.chat_rounded,
                color: sidonBlueChat,
              ))
        ],
      ),
      body: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          if (provider.status == DataStatus.loading ||
              provider.detail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.status == DataStatus.error) {
            return const Center(
              child: Text('Error al cargar el detalle'),
            );
          }

          final TicketDetailModel? ticketData = provider.detail;
          final DateFormat formatter = DateFormat('dd/MM/yyyy');
          final whoCreated = ticketData?.createdby;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sección de detalles del ticket
                Card(
                  elevation: 4,
                  color: veryLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'General',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        buildDetailRow(
                          'Título',
                          ticketData!.title,
                          CrossAxisAlignment.start,
                        ),
                        buildDetailRow(
                          'Área',
                          ticketData.area,
                          CrossAxisAlignment.start,
                        ),
                        buildDetailRow(
                          'Descripción',
                          ticketData.reason,
                          CrossAxisAlignment.start,
                        ),
                        buildDetailRow(
                          'Fecha de creación',
                          widget.ticket.createdat,
                          CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //! Sección de detalles de la sucursal
                //! Pendiente de agregar debido a los cambios en el modelo

                // Card(
                //   elevation: 4,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Información de la Sucursal',
                //           style: Theme.of(context)
                //               .textTheme
                //               .titleLarge
                //               ?.copyWith(fontWeight: FontWeight.bold),
                //         ),
                //         const Divider(),
                //         buildDetailRow('Sucursal',
                //             widget.maintenance.branchOfficeModel.description),
                //         buildDetailRow('Razón social',
                //             widget.maintenance.branchOfficeModel.subcompany),
                //         buildDetailRow('Dirección',
                //             widget.maintenance.branchOfficeModel.location),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 16),
                //!==================================================================
                // Sección de contacto
                Card(
                  elevation: 4,
                  color: veryLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contacto',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        buildDetailRow(
                          'Creado por',
                          whoCreated!.name,
                          CrossAxisAlignment.start,
                        ),
                        buildDetailRow(
                          'Teléfono',
                          whoCreated.phone,
                          CrossAxisAlignment.start,
                        ),
                        buildDetailRow(
                          'Correo',
                          whoCreated.email,
                          CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Otros detalles
                Card(
                  elevation: 4,
                  color: veryLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Otros Detalles',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        (ticketData.followup.schedule == null)
                            ? buildDetailRow(
                                'Agendado para',
                                'Sin agendar',
                                CrossAxisAlignment.start,
                              )
                            : buildDetailRow(
                                'Agendado para',
                                formatter.format(DateTime.parse(
                                    ticketData.followup.schedule!.scheduledat)),
                                CrossAxisAlignment.start,
                              ),
                        (ticketData.followup.schedule == null)
                            ? buildDetailRow(
                                'Tiempo estimado',
                                'Sin registro',
                                CrossAxisAlignment.start,
                              )
                            : buildDetailRow(
                                'Tiempo estimado',
                                _formatTime(
                                    ticketData.followup.schedule!.atentionat),
                                CrossAxisAlignment.start,
                              ),
                        (ticketData.price == null)
                            ? buildDetailRow(
                                'Cotización',
                                '\$0.00 MXN',
                                CrossAxisAlignment.start,
                              )
                            : buildDetailRow(
                                'Cotización',
                                ticketData.price!.price,
                                CrossAxisAlignment.start,
                              ),
                        (ticketData.assignment == null)
                            ? buildDetailRow(
                                'Asignado a',
                                'Sin asignar',
                                CrossAxisAlignment.start,
                              )
                            : buildDetailRow(
                                'Asignado a',
                                ticketData.assignment!.asignedto.name,
                                CrossAxisAlignment.start,
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 20, // Espacio horizontal entre botones
                  runSpacing: 20, // Espacio vertical entre filas
                  alignment: WrapAlignment.center, // Centra los elementos
                  children: [
                    buildVerticalButton(
                      context: context,
                      icon: Icons.check,
                      label: "Realizado",
                      onPressed: () {},
                    ),
                    // buildVerticalButton(
                    //   context: context,
                    //   icon: Icons.calendar_month_outlined,
                    //   label: "Agendar",
                    //   onPressed: () {},
                    // ),
                    // buildVerticalButton(
                    //   context: context,
                    //   icon: Icons.person_add_alt_1,
                    //   label: "Asignar",
                    //   onPressed: () {},
                    // ),
                    // El cuarto se pondría al lado del tercero,
                    // y el quinto bajaría a una nueva fila.
                  ],
                )

                //! Mapa de la locación de la sucursal
                //! PENDIENTE DE AGREGAR DEBIDO AL CAMBIO EN EL MODELO

                // Card(
                //   elevation: 4,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Ubicación del servicio',
                //           style: Theme.of(context)
                //               .textTheme
                //               .titleLarge
                //               ?.copyWith(fontWeight: FontWeight.bold),
                //         ),
                //         const Divider(),
                //         SizedBox(
                //           height: 250,
                //           child: TicketMapWidget(
                //             location: LatLng(
                //                 double.parse(
                //                     widget.maintenance.branchOfficeModel.latitud),
                //                 double.parse(
                //                   widget.maintenance.branchOfficeModel.longitud,
                //                 )),
                //             address: widget.maintenance.branchOfficeModel.location,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 50),

                //! ==================================================
              ],
            ),
          );
        },
      ),
      // floatingActionButton: Consumer<DetailProvider>(
      //   builder: (context, provider, child) {
      //     if (provider.status == DataStatus.loading ||
      //         provider.detail == null) {
      //       return const SizedBox.shrink();
      //     }

      //     final TicketDetailModel ticketData = provider.detail!;
      //     if (ticketData.status.toLowerCase() == 'realizado') {
      //       return const SizedBox.shrink();
      //     }

      //     return SpeedDialDetailTicket(
      //       ticketId: ticketData.ticketId,
      //       userId: userSession.currentUser!.userId,
      //       status: ticketData.status,
      //     );
      //   },
      // ),
    );
  }

  // Widget de ayuda para construir filas de detalles de forma consistente
  Widget buildDetailRow(
      String label, String value, CrossAxisAlignment alignment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: alignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _formatTime(int minutes) {
    if (minutes == 30) {
      return '30 minutos';
    }
    if (minutes % 60 == 0) {
      int hours = minutes ~/ 60;
      return '$hours hora${hours > 1 ? 's' : ''}';
    }
    double hours = minutes / 60;
    return '${hours.toStringAsFixed(1)} horas';
  }

  Widget buildVerticalButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color color = sidonSecondaryColor, // Color púrpura de tus diseños previos
  }) {
    final double itemWidth = (MediaQuery.of(context).size.width - 60) / 2;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: itemWidth,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: sidonPrimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Hace que el botón solo ocupe el espacio necesario
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            const SizedBox(height: 4), // Espacio entre icono y texto
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
