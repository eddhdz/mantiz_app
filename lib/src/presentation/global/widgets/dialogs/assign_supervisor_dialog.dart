import 'package:flutter/material.dart';
import 'package:mantiz/src/data/models/supplier_response_model.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/providers/ticket_detail/supplier_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/providers/ticket_detail/branchoffice_provider.dart';

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
  String? _selectedSupplierId;
  String? _selectedBranchofficeId;
  String? _selectedSupervisorId;

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
    // return

    // Consumer<SupplierProvider>(
    //   builder: (context, provider, child) {
    //     Widget dropdownContent;
    //     switch (provider.status) {
    //       case DataStatus.loading:
    //         dropdownContent = const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //         break;
    //       case DataStatus.error:
    //         dropdownContent = const Center(
    //           child: Text('Error'),
    //         );
    //         break;
    //       case DataStatus.loaded:
    //         dropdownContent = _buildDropdown(
    //             provider.suppliers!, _selectedSupplierId, (newValue) {
    //           setState(() {
    //             _selectedSupplierId = newValue;
    //             _selectedBranchofficeId = null;
    //             _selectedSupervisorId = null;
    //           });
    //         });
    //         break;
    //       default:
    //         dropdownContent = const SizedBox.shrink();
    //         break;
    //     }

    return AlertDialog(
      title: const Text('Asignar Supervisor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Dropdown Proveedor
            const Text(
              'Proveedor:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildSupplierDropdown(),
            const SizedBox(height: 16),

            //Dropdown sucursales
            const Text(
              'Sucursal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildBranchofficeDropdown(),
            const SizedBox(height: 16),

            //Dropdown Supervisores
            const Text(
              'Supervisor:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildDropdown(
              [],
              _selectedSupervisorId,
              null,
              enabled: false,
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
          onPressed: (_selectedSupplierId != null &&
                  _selectedBranchofficeId != null &&
                  _selectedSupervisorId != null)
              ? () {
                  // Lógica para guardar
                  Navigator.of(context).pop();
                }
              : null, // El botón estará deshabilitado si faltan selecciones
          child: const Text('Asignar'),
        )
      ],
    );
    //   },
    // );
  }

  Widget _buildSupplierDropdown() {
    return Consumer<SupplierProvider>(
      builder: (context, provider, child) {
        if (provider.status == DataStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.status == DataStatus.error) {
          return const Center(
            child: Text('Error al cargar Proveedores'),
          );
        }
        if (provider.suppliers == null || provider.suppliers!.isEmpty) {
          return const Text('No se encontraron proveedores.');
        }
        return _buildDropdown(
            provider.suppliers!
                .map((s) => DropdownMenuItem(
                      value: s.id.toString(),
                      child: Text(s.supplier),
                    ))
                .toList(),
            _selectedSupplierId, (newValue) {
          setState(() {
            _selectedSupplierId = newValue;
            _selectedBranchofficeId = null;
            _selectedSupervisorId = null;
          });
          Provider.of<BranchofficeProvider>(context, listen: false)
              .fetchBranchoffices(newValue!);
        }, enabled: true);
      },
    );
  }

  Widget _buildBranchofficeDropdown() {
    return Consumer<BranchofficeProvider>(
      builder: (context, provider, child) {
        if (_selectedSupplierId == null) {
          return _buildDropdown([], null, null, enabled: false);
        }

        if (provider.status == DataStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.status == DataStatus.error) {
          return const Center(child: Text('Error al cargar sucursales'));
        }
        if (provider.branchoffices == null || provider.branchoffices!.isEmpty) {
          return _buildDropdown([], null, null, enabled: false);
        }

        return _buildDropdown(
          provider.branchoffices!
              .map((bo) => DropdownMenuItem(
                    value: bo.id.toString(),
                    child: Text(bo.branchoffice.description),
                  ))
              .toList(),
          _selectedBranchofficeId,
          (newValue) {
            setState(() {
              _selectedBranchofficeId = newValue;
              // Aquí podrías disparar la llamada para los supervisores
              // _selectedSupervisorId = null;
            });
          },
          enabled: true,
        );
      },
    );
  }

  _buildDropdown(List<DropdownMenuItem<String>> items, String? selectedValue,
      Function(String?)? onChanged,
      {required bool enabled}) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedValue,
      items: items,
      onChanged: enabled ? onChanged : null, // Se le pasa el callback o null
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}
