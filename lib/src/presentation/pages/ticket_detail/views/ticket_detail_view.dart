import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_for_provider.dart';

import '../../../../data/models/models.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/providers/ticket_detail/assigned_to_provider.dart';
import '../../../global/widgets/maps/ticket_map.dart';
import '../../../global/widgets/speed_dials/speed_dial_detail_ticket.dart';
import '../../../routes/routes.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DetailTicketView extends StatefulWidget {
  final MaintenancesModel maintenance;

  const DetailTicketView({super.key, required this.maintenance});

  @override
  State<DetailTicketView> createState() => _DetailTicketViewState();
}

class _DetailTicketViewState extends State<DetailTicketView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AssignedToProvider>(context, listen: false)
          .fetchAssignedTo(widget.maintenance.id.toString());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScheduleForProvider>(context, listen: false)
          .fetchScheduleFor(widget.maintenance.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy \'a las\' HH:mm \'horas\'');
    final String createdAtFormatted =
        formatter.format(widget.maintenance.createdAt);
    final whoCreated = widget.maintenance.whoPartnerCreatedModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Servicio ${widget.maintenance.folio}"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                const storage = FlutterSecureStorage();
                String? fkPartnerLicence =
                    await storage.read(key: 'fkPartnerLicence');
                Navigator.pushNamed(
                    // ignore: use_build_context_synchronously
                    context,
                    Routes.trackingTicket,
                    arguments: [
                      widget.maintenance.id,
                      int.parse(fkPartnerLicence!),
                    ]);
              },
              icon: const Icon(Icons.chat_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de detalles del ticket
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles del Ticket',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    buildDetailRow('Título', widget.maintenance.description),
                    buildDetailRow('Estatus', widget.maintenance.status),
                    buildDetailRow('Área', widget.maintenance.area ?? 'N/A'),
                    buildDetailRow('Descripción', widget.maintenance.reason),
                    buildDetailRow('Fecha de creación', createdAtFormatted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sección de detalles de la sucursal
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de la Sucursal',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    buildDetailRow('Sucursal',
                        widget.maintenance.branchOfficeModel.description),
                    buildDetailRow('Razón social',
                        widget.maintenance.branchOfficeModel.subcompany),
                    buildDetailRow('Dirección',
                        widget.maintenance.branchOfficeModel.location),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sección de contacto
            Card(
              elevation: 4,
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
                    buildDetailRow('Creado por', whoCreated?.fullname ?? 'N/A'),
                    buildDetailRow('Teléfono', whoCreated?.phone ?? 'N/A'),
                    buildDetailRow('Correo', whoCreated?.email ?? 'N/A'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Otros detalles
            Card(
              elevation: 4,
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
                    Consumer<ScheduleForProvider>(
                      builder: (context, provider, child) {
                        String scheduledForValue = 'Sin agendar';
                        Widget scheduledForWidget;

                        switch (provider.status) {
                          case DataStatus.initial:
                            scheduledForWidget = buildDetailRow(
                                'Agendado para', scheduledForValue);
                            break;
                          case DataStatus.loading:
                            scheduledForWidget =
                                const CircularProgressIndicator();
                            break;
                          case DataStatus.loaded:
                            if (provider.scheduled != null &&
                                provider.scheduled!.isNotEmpty) {
                              scheduledForValue = formatter
                                  .format(provider.scheduled!.first.atentionAt);
                              scheduledForWidget = buildDetailRow(
                                  'Agendado para', scheduledForValue);
                            } else {
                              scheduledForWidget = buildDetailRow(
                                  'Agendado para', scheduledForValue);
                            }
                            break;
                          case DataStatus.error:
                            scheduledForWidget =
                                buildDetailRow('Agendado para', 'Sin agendar');
                            break;
                          default:
                            scheduledForWidget = buildDetailRow(
                                'Agendado para', scheduledForValue);
                            break;
                        }
                        return scheduledForWidget;
                      },
                    ),
                    Consumer<ScheduleForProvider>(
                      builder: (context, provider, child) {
                        String scheduledForValue = 'Sin registro';
                        Widget scheduledForWidget;

                        switch (provider.status) {
                          case DataStatus.initial:
                            scheduledForWidget = buildDetailRow(
                                'Tiempo estimado', scheduledForValue);
                            break;
                          case DataStatus.loading:
                            scheduledForWidget =
                                const CircularProgressIndicator();
                            break;
                          case DataStatus.loaded:
                            if (provider.scheduled != null &&
                                provider.scheduled!.isNotEmpty) {
                              scheduledForValue = _formatTime(
                                  provider.scheduled!.first.atentionTime);
                              scheduledForWidget = buildDetailRow(
                                  'Tiempo estimado', scheduledForValue);
                            } else {
                              scheduledForWidget = buildDetailRow(
                                  'Tiempo estimado', scheduledForValue);
                            }
                            break;
                          case DataStatus.error:
                            scheduledForWidget = buildDetailRow(
                                'Tiempo estimado', 'Sin registro');
                            break;
                          default:
                            scheduledForWidget = buildDetailRow(
                                'Tiempo estimado', scheduledForValue);
                            break;
                        }
                        return scheduledForWidget;
                      },
                    ),
                    buildDetailRow('Cotización', '0.00 MXN'),
                    Consumer<AssignedToProvider>(
                      builder: (context, provider, child) {
                        String assignedToValue = 'Sin asignar';
                        Widget assignedToWidget;

                        // Manejar los diferentes estados del provider
                        switch (provider.status) {
                          case DataStatus.initial:
                            assignedToWidget =
                                buildDetailRow('Asignado a', assignedToValue);
                            break;
                          case DataStatus.loading:
                            assignedToWidget =
                                const CircularProgressIndicator();
                            break;
                          case DataStatus.loaded:
                            // Si la lista de asignaciones no está vacía, muestra el nombre
                            if (provider.assigned != null &&
                                provider.assigned!.isNotEmpty) {
                              assignedToValue =
                                  provider.assigned!.first.tosasigned.fullname;
                              assignedToWidget =
                                  buildDetailRow('Asignado a', assignedToValue);
                            } else {
                              assignedToWidget =
                                  buildDetailRow('Asignado a', assignedToValue);
                            }
                            break;
                          case DataStatus.error:
                            assignedToWidget =
                                buildDetailRow('Asignado a', 'No asignado');
                            break;
                          default:
                            assignedToWidget =
                                buildDetailRow('Asignado a', assignedToValue);
                            break;
                        }
                        return assignedToWidget;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ubicación del servicio',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 250,
                      child: TicketMapWidget(
                        location: LatLng(
                            double.parse(
                                widget.maintenance.branchOfficeModel.latitud),
                            double.parse(
                              widget.maintenance.branchOfficeModel.longitud,
                            )),
                        address: widget.maintenance.branchOfficeModel.location,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: Consumer<AssignedToProvider>(
        builder: (context, provider, child) {
          final scheduleProvider =
              Provider.of<ScheduleForProvider>(context, listen: false);

          String assignCurrentStatus = widget.maintenance.status;
          String scheduleCurrentStatus = widget.maintenance.status;

          if (provider.status == DataStatus.loaded &&
              provider.assigned != null &&
              provider.assigned!.isNotEmpty) {
            assignCurrentStatus = 'Asignado';
          }

          if (scheduleProvider.status == DataStatus.loaded &&
              scheduleProvider.scheduled != null &&
              scheduleProvider.scheduled!.isNotEmpty) {
            scheduleCurrentStatus = 'Agendado';
          }
          return SpeedDialDetailTicket(
            fkMaintenance: widget.maintenance.id,
            assignStatus: assignCurrentStatus,
            scheduleStatus: scheduleCurrentStatus,
          );
        },
      ),
    );
  }

  // Widget de ayuda para construir filas de detalles de forma consistente
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
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
}
