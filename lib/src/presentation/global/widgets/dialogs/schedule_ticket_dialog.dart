import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/schedule_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/providers/ticket_detail/add_message_provider.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';

class ScheduleTicketDialog extends StatefulWidget {
  final int fkMaintenance;
  final int scheduleByPartner;
  const ScheduleTicketDialog({
    super.key,
    required this.fkMaintenance,
    required this.scheduleByPartner,
  });

  @override
  State<ScheduleTicketDialog> createState() => _ScheduleTicketDialogState();
}

class _ScheduleTicketDialogState extends State<ScheduleTicketDialog> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedDuration = '30 minutos';

  final Map<String, int> _durationMap = {
    '30 minutos': 30,
    '1 hora': 60,
    '1.5 horas': 90,
    '2 horas': 120,
    '3 horas': 180,
    '4 horas': 240,
    '5 horas': 300,
    '6 horas': 360,
    '7 horas': 420,
  };
  final List<String> _durations = [
    '30 minutos',
    '1 hora',
    '1.5 horas',
    '2 horas',
    '3 horas',
    '4 horas',
    '5 horas',
    '6 horas',
    '7 horas',
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Programar Servicio'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Selector de Fecha ---
                const Text(
                  'Fecha de inicio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ListTile(
                  title: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
                const Divider(),

                // --- Selector de Hora ---
                const Text(
                  'Hora de inicio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ListTile(
                  title: Text(
                    _selectedTime.format(context),
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (picked != null && picked != _selectedTime) {
                      setState(() {
                        _selectedTime = picked;
                      });
                    }
                  },
                ),
                const Divider(),

                // --- Selector de Tiempo Estimado ---
                const Text(
                  'Tiempo estimado',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedDuration,
                  items: _durations.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedDuration = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        Consumer<ScheduleProvider>(
          builder: (context, provider, child) {
            if (provider.status == DataStatus.loading) {
              return const CircularProgressIndicator();
            }

            return ElevatedButton(
              onPressed: () async {
                final int estimatedMinutes =
                    _durationMap[_selectedDuration] ?? 0;

                final DateTime combinedDateTime = DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  _selectedTime.hour,
                  _selectedTime.minute,
                );

                // Formato de fecha para el API: "YYYY-MM-DD HH:MM:SS"
                final String formattedDateTime =
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime);

                await provider.scheduleTicket(
                  widget.fkMaintenance,
                  widget.scheduleByPartner,
                  estimatedMinutes,
                  formattedDateTime,
                );

                if (provider.status == DataStatus.success) {
                  final addMessageProvider = Provider.of<AddMessageProvider>(
                    // ignore: use_build_context_synchronously
                    context,
                    listen: false,
                  );
                  const message =
                      'Ticket agendado desde app movil para su seguimineto';
                  await addMessageProvider.addMessage(
                      widget.fkMaintenance, widget.scheduleByPartner, message);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: veryLightGray,
                        ),
                        Text(
                          'Ticket agendado con éxito',
                          style: TextStyle(color: veryLightGray),
                        )
                      ],
                    ),
                    backgroundColor: mediumGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    padding: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 3),
                  ));
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, Routes.home);
                } else if (provider.status == DataStatus.error) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error desconocido')));
                }
              },
              child: const Text('Agendar'),
            );
          },
        ),
      ],
    );
  }
}
