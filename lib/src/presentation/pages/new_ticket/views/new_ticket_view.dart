import 'package:flutter/material.dart';

import '../../../../data/models/device_model.dart';
import '../../../../data/models/failure_model.dart';
import '../../../../data/models/models.dart';
import '../../../../data/models/zone_model.dart';
import '../../../global/colors.dart';
import '../../../global/viewers/image_viewer.dart';
import '../../../global/viewers/video_viewer.dart';
import '../../../global/widgets/buttons/general_button.dart';
import '../../../global/widgets/containers/rounded_container.dart';
import '../../../global/widgets/customs/custom_dialog_general.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../../global/widgets/texts/general_text_form.dart';
import '../../../routes/routes.dart';

import 'package:provider/provider.dart';
import 'new_ticket_view_vm.dart';

class NewTicketView extends StatefulWidget {
  const NewTicketView({super.key});

  @override
  State<NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<NewTicketView> {
  // TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final vmInit = Provider.of<NewTicketViewVM>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.loadCustomer(context);
    });
  }

  @override
  void dispose() {
    // titleController.dispose();
    descriptionController.dispose();
    // areaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewTicketViewVM>(context);
    Size screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {}
      },
      child: Scaffold(
        backgroundColor: whiteGlobalColor,
        appBar: AppBar(
            leading: Container(),
            backgroundColor: whiteGlobalColor,
            title: const GeneralText(
                mensaje: 'Nuevo ticket', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.center),
            actions: [(vm.isLoading) ? const Image(image: AssetImage('lib/src/assets/customs/Wait03@4x.gif'), fit: BoxFit.scaleDown) : Container()]),
        body: SizedBox(
            child: Column(children: [
          Expanded(
              child: SizedBox(
                  child: SingleChildScrollView(
                      child: SizedBox(
                          child: Form(
                              key: vm.formKey,
                              child: Column(children: <Widget>[
                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Descripción:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left)
                                ]),
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

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Cliente:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left)
                                ]),
                                const SizedBox(height: 5),
                                Container(
                                    width: screenSize.width,
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

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Sucursal:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left)
                                ]),
                                const SizedBox(height: 5),
                                Container(
                                    width: screenSize.width,
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
                                      // validator: (value) => vm.validatorCustomer(value),
                                    )),

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Zona:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)
                                ]),
                                const SizedBox(height: 5),
                                Container(
                                    width: screenSize.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButtonFormField<ZoneModel>(
                                      value: vm.selectedZones,
                                      items: vm.zones.map((ZoneModel zone) {
                                        return DropdownMenuItem<ZoneModel>(
                                            value: zone,
                                            child: GeneralText(
                                                mensaje: zone.zone,
                                                maxLines: 1,
                                                overFlow: TextOverflow.ellipsis,
                                                size: 15,
                                                weight: FontWeight.normal,
                                                color: blackPanter,
                                                align: TextAlign.start));
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
                                      // validator: (value) => vm.validatorCustomer(value),
                                    )),

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Dispositivo:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left)
                                ]),
                                const SizedBox(height: 5),
                                Container(
                                    width: screenSize.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DropdownButtonFormField<DeviceModel>(
                                      value: vm.selectedDevice,
                                      items: vm.devices.map((DeviceModel device) {
                                        return DropdownMenuItem<DeviceModel>(
                                            value: device,
                                            child: Row(children: [
                                              SizedBox(
                                                  width: 200,
                                                  child: GeneralText(
                                                      mensaje: '${device.name}-${device.priority}',
                                                      maxLines: 1,
                                                      overFlow: TextOverflow.ellipsis,
                                                      size: 15,
                                                      weight: FontWeight.normal,
                                                      color: blackPanter,
                                                      align: TextAlign.start)),
                                              const SizedBox(width: 5),
                                              Row(
                                                  children: List.generate(
                                                      5,
                                                      (index) => Icon(
                                                            index < device.rating! ? Icons.star : Icons.star_border,
                                                            color: greenPrincipal,
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
                                      // validator: (value) => vm.validatorCustomer(value),
                                    )),

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Falla:', maxLines: 1, overFlow: TextOverflow.ellipsis, size: 15, weight: FontWeight.bold, color: blackPanter, align: TextAlign.left)
                                ]),
                                const SizedBox(height: 5),
                                Container(
                                    width: screenSize.width,
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
                                    )),

                                const Row(children: <Widget>[
                                  //!
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Título:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.start)
                                ]),
                                const SizedBox(height: 5),
                                Row(children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: GeneralText(
                                    mensaje: (vm.selectedBranch == null) ? '' : '${vm.selectedBranch!.clave}-${vm.selectedZones!.zone}-${vm.selectedDevice!.code}',
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    size: 18,
                                    weight: FontWeight.bold,
                                    color: blueNeutralGlobalColor,
                                    align: TextAlign.center,
                                  )),
                                  const SizedBox(width: 10),
                                ]),

                                //!
                                const SizedBox(height: 5),
                                const Row(children: <Widget>[
                                  SizedBox(width: 10),
                                  GeneralText(
                                      mensaje: 'Evidencia:',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      color: blackPanter,
                                      align: TextAlign.left)
                                ]),
                                const SizedBox(height: 10),

                                Column(children: [
                                  RoundedContainer(
                                      containerPropertiesModel: ContainerPropertiesModel(
                                          height: 230,
                                          width: screenSize.width,
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          alignment: Alignment.center,
                                          backColor: blueExtraLightGlobalColor,
                                          borderColor: mediumGray,
                                          borderWidth: 2,
                                          shadowColor: whiteGlobalColor,
                                          rounded: 20,
                                          widget: Row(children: [
                                            const SizedBox(width: 10),
                                            Column(children: [
                                              Expanded(child: Container()),
                                              GeneralButton(
                                                  text: 'Imagen galería', onPressed: () => vm.pickImage(context), color: blueNeutralGlobalColor, textColor: whiteGlobalColor),
                                              GeneralButton(
                                                  text: 'Tomar imagen', onPressed: () => vm.takePhoto(context), color: blueNeutralGlobalColor, textColor: whiteGlobalColor),
                                              GeneralButton(
                                                  text: 'Video galería', onPressed: () => vm.pickVideo(context), color: blueNeutralGlobalColor, textColor: whiteGlobalColor),
                                              GeneralButton(
                                                  text: 'Tomar video', onPressed: () => vm.recordVideo(context), color: blueNeutralGlobalColor, textColor: whiteGlobalColor),
                                              Expanded(child: Container()),
                                              const SizedBox(width: 10),
                                            ]),
                                            Expanded(child: Container()),
                                            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                              RoundedContainer(
                                                  containerPropertiesModel: ContainerPropertiesModel(
                                                      height: 130,
                                                      width: 170,
                                                      alignment: Alignment.center,
                                                      backColor: whiteGlobalColor,
                                                      borderColor: mediumGray,
                                                      shadowColor: blueExtraLightGlobalColor,
                                                      rounded: 1,
                                                      borderWidth: 2,
                                                      widget: (vm.pathVideoImage == null || vm.pathVideoImage!.isEmpty)
                                                          ? const Image(image: AssetImage('lib/src/assets/camera.png'), fit: BoxFit.scaleDown)
                                                          : (vm.typeFile == 'no conocido')
                                                              ? const Image(image: AssetImage('lib/src/assets/camera.png'), fit: BoxFit.scaleDown)
                                                              : (vm.typeFile!.contains('video'))
                                                                  ? VideoViewer(path: vm.pathVideoImage!, loop: true)
                                                                  : ImageViewer(file: vm.evidence!),
                                                      margin: const EdgeInsets.all(0))),
                                            ]),
                                            const SizedBox(width: 10),
                                          ]))),
                                  // Expanded(child: Container()),
                                ]),

                                const SizedBox(height: 10),
                              ])))))),
          SizedBox(
            height: 120,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              const SizedBox(width: 30),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: GeneralButton(
                      text: 'Ver tickets',
                      minimumSize: const Size(130, 50),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      onPressed: () async {
                        await vm.vmInit();

                        if (!context.mounted) return;

                        descriptionController.text = '';

                        Navigator.pushNamedAndRemoveUntil(context, Routes.startingPoint, (route) => false);
                        // Navigator.pushNamed(context, Routes.startingPoint);
                        // Navigator.pushNamed(context, Routes.startingPoint).then((value) async {
                        //   await vm.vmInit();

                        //   if (!context.mounted) return;
                        //   await vm.loadCustomer(context);

                        //   descriptionController.text = '';
                        // });
                      },
                      color: mediumGray,
                      textColor: whiteGlobalColor)),
              const SizedBox(width: 20),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: GeneralButton(
                      text: 'Crear',
                      minimumSize: const Size(130, 50),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      onPressed: () async {
                        if (vm.formKey.currentState!.validate()) {
                          String desc = '', url = '';

                          //! Realizar primero el guardado de la imágen (obtener json correspondiente) ...
                          if (vm.base64 == null && vm.base64!.isEmpty) {
                            desc = 'Debes tener cargada una imágen.';
                            url = 'lib/src/assets/customs/Exception@4x.png';
                          } else {
                            await vm.savePhoto(context);
                            if (vm.finishSavePhoto) {
                              if (context.mounted) {
                                await vm.saveTicket(context);
                              }

                              if (vm.finishSaveTicket) {
                                desc = 'Ticket guardado satisfactoriamente ||Continúa agregando tickets o presiona <Cancelar> para salir.';
                                url = 'lib/src/assets/customs/Information@4x.png';
                              } else {
                                desc = 'Ocurrió un error al guardar el ticket, vuelve a intentar el procedimiento';
                                url = 'lib/src/assets/customs/Exception@4x.png';
                              }
                            } else {
                              desc = 'Ocurrió un error al guardar la foto, vuelve a intentar el procedimiento';
                              url = 'lib/src/assets/customs/Exception@4x.png';
                            }
                          }

                          if (!context.mounted) return;
                          await showDialog(
                              context: context,
                              builder: (build) {
                                return CustomDialogGeneral(descriptions: desc, text: 'Ok', urlImage: url, altura: 260);
                              });

                          await vm.vmInit();

                          if (!context.mounted) return;
                          await vm.loadCustomer(context);

                          descriptionController.text = '';
                        } else {}
                      },
                      color: mediumGray,
                      textColor: whiteGlobalColor)),
              const SizedBox(width: 30),
            ]),
          )
        ])),
      ),
    );
  }
}
