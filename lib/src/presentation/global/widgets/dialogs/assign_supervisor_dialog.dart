import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/supplier_response_model.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supplier_provider.dart';
import 'package:provider/provider.dart';

class AssignSupervisorDialog extends StatefulWidget {
  final String fkPartnerLicence;
  const AssignSupervisorDialog({
    super.key,
    required this.fkPartnerLicence,
  });

  @override
  State<AssignSupervisorDialog> createState() => _AssignSupervisorDialogState();
}

class _AssignSupervisorDialogState extends State<AssignSupervisorDialog> {
  // Variables para guardar el valor seleccionado
  String? _selectedOption1;
  String? _selectedOption2;
  String? _selectedOption3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SupplierProvider>(context, listen: false)
          .fetchSuppliers(widget.fkPartnerLicence);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(
      builder: (context, provider, child) {
        Widget dropdownContent;
        switch (provider.status) {
          case DataStatus.loading:
            dropdownContent = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case DataStatus.error:
            dropdownContent = const Center(
              child: Text('Error'),
            );
            break;
          case DataStatus.loaded:
            dropdownContent = _buildDropdown(
                provider.suppliers!, _selectedOption1, (newValue) {
              setState(() {
                _selectedOption1 = newValue;
                _selectedOption2 = null;
                _selectedOption3 = null;
              });
            });
            break;
          default:
            dropdownContent = const SizedBox.shrink();
            break;
        }

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
                dropdownContent,
                const SizedBox(height: 16),

                //Dropdown 2
                const Text(
                  'Sucursal:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                dropdownContent,
                const SizedBox(height: 16),

                //Dropdown3
                const Text(
                  'Supervisor:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                dropdownContent,
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
      },
    );
  }

  _buildDropdown(
    List<Supplier> options,
    String? selectedValue,
    Function(String?)? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedValue,
      items: options.map<DropdownMenuItem<String>>((Supplier supplier) {
        return DropdownMenuItem<String>(
          value: supplier.id.toString(),
          child: Text(supplier.supplier),
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
