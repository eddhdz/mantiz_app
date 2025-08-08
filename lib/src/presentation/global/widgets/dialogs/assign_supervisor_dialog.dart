import 'package:flutter/material.dart';

class AssignSupervisorDialog extends StatefulWidget {
  const AssignSupervisorDialog({super.key});

  @override
  State<AssignSupervisorDialog> createState() => _AssignSupervisorDialogState();
}

class _AssignSupervisorDialogState extends State<AssignSupervisorDialog> {
  // Datos de ejemplo para los dropdowns
  final List<String> _options1 = [
    'Opcion1',
    'Opcion2',
    'Opcion3',
  ];

  final List<String> _options2 = [
    'Opcion1',
    'Opcion2',
    'Opcion3',
  ];

  final List<String> _options3 = [
    'Opcion1',
    'Opcion2',
    'Opcion3',
  ];

  // Variables para guardar el valor seleccionado
  String? _selectedOption1;

  String? _selectedOption2;

  String? _selectedOption3;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Asignar Supervisor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Dropdown 1
            const Text(
              'Proveedor:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildDropdown(
              _options1,
              _selectedOption1,
              (newValue) {
                setState(() {
                  _selectedOption1 = newValue;
                  _selectedOption2 = null;
                  _selectedOption3 = null;
                });
              },
            ),
            const SizedBox(height: 16),

            //Dropdown 2
            const Text(
              'Sucursal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildDropdown(
              _options2,
              _selectedOption2,
              _selectedOption1 != null
                  ? (newValue) {
                      setState(() {
                        _selectedOption2 = newValue;
                        _selectedOption3 = null;
                      });
                    }
                  : null,
            ),
            const SizedBox(height: 16),

            //Dropdown3
            const Text(
              'Supervisor:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildDropdown(
              _options3,
              _selectedOption3,
              (_selectedOption1 != null && _selectedOption2 != null)
                  ? (newValue) {
                      setState(() {
                        _selectedOption3 = newValue;
                      });
                    }
                  : null,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        TextButton(
          onPressed: (_selectedOption1 != null &&
                  _selectedOption2 != null &&
                  _selectedOption3 != null)
              ? () {
                  // Lógica para guardar
                  Navigator.of(context).pop();
                }
              : null, // El botón estará deshabilitado si faltan selecciones
          child: const Text('Asignar'),
        )
      ],
    );
  }

  _buildDropdown(
    List<String> options,
    String? selectedValue,
    Function(String?)? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedValue,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged, // Se le pasa el callback o null
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}
