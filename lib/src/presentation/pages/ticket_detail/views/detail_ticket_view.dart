import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/models.dart';
import '../../../global/widgets/maps/ticket_map.dart';
import '../../../global/widgets/speed_dials/speed_dial_detail_ticket.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailTicketView extends StatelessWidget {
  final MaintenancesModel maintenance;

  const DetailTicketView({super.key, required this.maintenance});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy \'a las\' HH:mm \'horas\'');
    final String createdAtFormatted =
        formatter.format(maintenance.createdAt.toLocal());
    final whoCreated = maintenance.whoPartnerCreatedModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Servicio ${maintenance.folio}"),
        centerTitle: true,
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
                    buildDetailRow('Título', maintenance.description),
                    buildDetailRow('Estatus', maintenance.status),
                    buildDetailRow('Área', maintenance.area ?? 'N/A'),
                    buildDetailRow('Descripción', maintenance.reason),
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
                    buildDetailRow(
                        'Sucursal', maintenance.branchOfficeModel.description),
                    buildDetailRow('Razón social',
                        maintenance.branchOfficeModel.subcompany),
                    buildDetailRow(
                        'Dirección', maintenance.branchOfficeModel.location),
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
                    buildDetailRow('Agendado para', 'Sin agendar'),
                    buildDetailRow('Tiempo estimado', 'Sin registro'),
                    buildDetailRow('Cotización', '0.00 MXN'),
                    buildDetailRow('Asignado a', 'Sin asignar'),
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
                            double.parse(maintenance.branchOfficeModel.latitud),
                            double.parse(
                              maintenance.branchOfficeModel.longitud,
                            )),
                        address: maintenance.branchOfficeModel.location,
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
      floatingActionButton:
          SpeedDialDetailTicket(fkMaintenance: maintenance.id),
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
}
