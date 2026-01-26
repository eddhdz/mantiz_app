import 'package:flutter/material.dart';

import '../../../../data/models/branch_office_model.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/models/device_model.dart';
import '../../../../data/models/failure_model.dart';
import '../../../../data/models/general_text_properties_model.dart';
import '../../../../data/models/zone_model.dart';
import '../../../pages/new_ticket/views/new_ticket_view_vm.dart';
import '../../colors.dart';
import '../texts/general_text.dart';
import '../texts/general_text_form.dart';

import 'package:provider/provider.dart';

class TechnicalDataForm extends StatefulWidget {
  const TechnicalDataForm({super.key});

  @override
  State<TechnicalDataForm> createState() => _TechnicalDataFormState();
}

class _TechnicalDataFormState extends State<TechnicalDataForm> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    descriptionController.text = '';

    final vmInit = Provider.of<NewTicketViewVM>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.loadCustomer(context);
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewTicketViewVM>(context);

    // Resetear el controller cuando se guarde exitosamente el ticket
    if (vm.finishSaveTicket && descriptionController.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        descriptionController.clear();
        vm.onChangeDescription('');
      });
    }

    return Container(
        color: whiteGlobalColor,
        child: Form(
            key: vm.formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Título:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.start)),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GeneralText(
                    mensaje: (vm.selectedBranch == null) ? '' : '${vm.selectedBranch!.clave}-${vm.selectedZones!.zone}-${vm.selectedDevice!.code}',
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                    size: 18,
                    weight: FontWeight.bold,
                    color: blueNeutralGlobalColor,
                    align: TextAlign.center,
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                    mensaje: 'Descripción:',
                    maxLines: 1,
                    overFlow: TextOverflow.ellipsis,
                    size: 15,
                    weight: FontWeight.bold,
                    color: blackPanter,
                    align: TextAlign.left,
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GeneralTextForm(
                      properties: GeneralTextPropertiesModel(
                          label: '',
                          enable: true,
                          objectsColor: mediumGray,
                          textColor: blackPanter,
                          obscureText: false,
                          validator: (value) => null,
                          // validator: (value) => vm.generalValidator(value),
                          onChange: (value) {
                            vm.onChangeDescription(value);

                            descriptionController.text = value;
                          },
                          controller: descriptionController,
                          keyboard: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3))),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Cliente:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<CustomerModel>(
                    value: vm.selectedCustomer,
                    items: vm.customers.map((CustomerModel customer) {
                      return DropdownMenuItem<CustomerModel>(
                          value: customer,
                          child: GeneralText(
                              mensaje: customer.customer,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              size: 15,
                              weight: FontWeight.normal,
                              color: blackPanter,
                              align: TextAlign.start));
                    }).toList(),
                    onChanged: (CustomerModel? value) {
                      if (value != null) {
                        vm.customerSelectedAction(context, value);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mediumGray),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    // validator: (value) => vm.validatorCustomer(value),
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Sucursal:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<BranchOfficeModel>(
                    value: vm.selectedBranch,
                    items: vm.branchs.map((BranchOfficeModel branch) {
                      return DropdownMenuItem<BranchOfficeModel>(
                          value: branch,
                          child: GeneralText(
                              mensaje: branch.branchoffice,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              size: 15,
                              weight: FontWeight.normal,
                              color: blackPanter,
                              align: TextAlign.start));
                    }).toList(),
                    onChanged: (BranchOfficeModel? value) {
                      if (value != null) {
                        vm.branchSelectedAction(context, value);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mediumGray),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    // validator: (value) => vm.validatorBranch(value),
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Zona:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)),
              const SizedBox(height: 10),
              Container(
                  // width: screenSize.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<ZoneModel>(
                    value: vm.selectedZones,
                    items: vm.zones.map((ZoneModel zone) {
                      return DropdownMenuItem<ZoneModel>(
                          value: zone,
                          child: GeneralText(
                              mensaje: zone.zone, maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.normal, color: blackPanter, align: TextAlign.start));
                    }).toList(),
                    onChanged: (ZoneModel? value) {
                      if (value != null) {
                        vm.zonesSelectedAction(context, value);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mediumGray),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    // validator: (value) => vm.validatorZone(value),
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Dispositivo:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<DeviceModel>(
                    value: vm.selectedDevice,
                    selectedItemBuilder: (context) {
                      return vm.devices.map((device) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: GeneralText(
                                  mensaje: '${device.name} - ${device.priority}',
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  size: 15,
                                  weight: FontWeight.normal,
                                  color: sidonBackgroundDarkColor,
                                  align: TextAlign.start,
                                )),
                          ],
                        );
                      }).toList();
                    },
                    items: vm.devices.map((DeviceModel device) {
                      return DropdownMenuItem<DeviceModel>(
                          value: device,
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            SizedBox(
                                child: GeneralText(
                                    mensaje: '${device.name} - ${device.priority}',
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    size: 15,
                                    weight: FontWeight.normal,
                                    color: sidonBackgroundDarkColor,
                                    align: TextAlign.start)),
                            const SizedBox(width: 5),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                    5,
                                    (index) => Icon(
                                          index < device.rating! ? Icons.star : Icons.star_border,
                                          color: sidonPrimaryColor,
                                          size: 18,
                                        )))
                          ]));
                    }).toList(),
                    onChanged: (DeviceModel? value) {
                      if (value != null) {
                        vm.deviceSelectedAction(context, value);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mediumGray),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    // validator: (value) => vm.validatorDevice(value),
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const GeneralText(
                      mensaje: 'Falla:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<FailureModel>(
                    value: vm.selectedFailures,
                    items: vm.failures.map((FailureModel failure) {
                      return DropdownMenuItem<FailureModel>(
                          value: failure,
                          child: GeneralText(
                              mensaje: failure.description,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              size: 15,
                              weight: FontWeight.normal,
                              color: blackPanter,
                              align: TextAlign.start));
                    }).toList(),
                    onChanged: (FailureModel? value) {
                      if (value != null) {
                        vm.failureSelectedAction(context, value);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: mediumGray),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                    // validator: (value) => vm.validatorFail(value),
                  )),
              const SizedBox(height: 20),
            ])));
  }
}
