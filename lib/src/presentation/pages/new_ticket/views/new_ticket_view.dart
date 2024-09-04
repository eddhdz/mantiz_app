import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../global/colors.dart';
import '../../../global/customs/custom_dialog_question.dart';
import '../../../global/widgets/buttons/general_button.dart';
import '../../../global/widgets/containers/rounded_container.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../../../global/widgets/texts/general_text_form.dart';

import 'package:mantiz/src/presentation/pages/new_ticket/views/new_ticket_view_vm.dart';
import 'package:provider/provider.dart';

class NewTicketView extends StatefulWidget {
  const NewTicketView({super.key});

  @override
  State<NewTicketView> createState() => _NewTicketViewState();
}

class _NewTicketViewState extends State<NewTicketView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController areaController = TextEditingController();

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
    titleController.dispose();
    descriptionController.dispose();
    areaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewTicketViewVM>(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const GeneralText(
              mensaje: 'Nuevo ticket',
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              size: 15,
              weight: FontWeight.bold,
              color: blackPanter,
              align: TextAlign.center)),
      body: SingleChildScrollView(
          child: SizedBox(
              child: Column(children: <Widget>[
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
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: GeneralTextForm(
                properties: GeneralTextPropertiesModel(
                    label: '',
                    enable: true,
                    objectsColor: blueLightGlobalColor,
                    textColor: blackPanter,
                    obscureText: false,
                    validator: null,
                    onChange: (value) {},
                    controller: titleController,
                    keyboard: TextInputType.text,
                    minLines: 1,
                    maxLines: 1))),

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
                    objectsColor: blueLightGlobalColor,
                    textColor: blackPanter,
                    obscureText: false,
                    validator: null,
                    onChange: (value) {},
                    controller: descriptionController,
                    keyboard: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3))),

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
        RoundedContainer(
            containerPropertiesModel: ContainerPropertiesModel(
                height: screenSize.height * 0.2,
                width: screenSize.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                backColor: blueExtraLightGlobalColor,
                borderColor: blueLightGlobalColor,
                borderWidth: 2,
                shadowColor: whiteGlobalColor,
                rounded: 20,
                widget: Row(children: [
                  const SizedBox(width: 10),
                  GeneralButton(
                      text: 'Cargar evidencia',
                      onPressed: () async {
                        bool? yesOrNo = await showDialog(
                            context: context,
                            builder: (build) {
                              return const CustomDialogQuestion(
                                  title: 'Evidencia',
                                  descriptions:
                                      '¿Deseas tomar foto o cargar imágen?',
                                  btnOk: 'Cámara',
                                  btnNotOk: 'Galería',
                                  altura: 200);
                            });

                        if (yesOrNo != null) {
                          await vm.vmInit();

                          if (yesOrNo) {
                            //! Abrimos cámara para tomar foto ...
                            await vm.goToCamera();
                          } else {
                            //! Cargamos una imágen de la galería ...
                            await vm.selectImage();
                          }
                        }
                      },
                      color: vm.evidenceColor,
                      textColor: blackPanter),
                  Expanded(child: Container()),
                  RoundedContainer(
                      containerPropertiesModel: ContainerPropertiesModel(
                          height: screenSize.height * 0.15,
                          width: screenSize.width * 0.3,
                          alignment: Alignment.center,
                          backColor: whiteGlobalColor,
                          borderColor: greenPrincipal,
                          shadowColor: blueExtraLightGlobalColor,
                          rounded: 1,
                          borderWidth: 2,
                          widget: (vm.evidence == null)
                              ? const Image(
                                  image:
                                      AssetImage('lib/src/assets/camera.png'),
                                  fit: BoxFit.scaleDown)
                              : Image.file(vm.evidence!, fit: BoxFit.scaleDown),
                          margin: const EdgeInsets.all(0))),
                  const SizedBox(width: 10),
                ]))),

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
                        mensaje: '${customer.id} - ${customer.customer}',
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
                borderSide: BorderSide(width: 3, color: blueLightGlobalColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
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
                        mensaje: '${branch.id} - ${branch.description}',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 15,
                        weight: FontWeight.normal,
                        color: blackPanter,
                        align: TextAlign.start));
              }).toList(),
              onChanged: (BranchOfficeModel? value) {
                if (value != null) {
                  vm.branchSelectedAction(value);
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: blueLightGlobalColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
            )),

        //!
        const SizedBox(height: 5),
        const Row(children: <Widget>[
          SizedBox(width: 10),
          GeneralText(
              mensaje: 'Área:',
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              size: 15,
              weight: FontWeight.bold,
              color: blackPanter,
              align: TextAlign.left)
        ]),
        const SizedBox(height: 5),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: GeneralTextForm(
                properties: GeneralTextPropertiesModel(
                    label: '',
                    enable: true,
                    objectsColor: blueLightGlobalColor,
                    textColor: blackPanter,
                    obscureText: false,
                    validator: null,
                    onChange: (value) {},
                    controller: areaController,
                    keyboard: TextInputType.text,
                    minLines: 1,
                    maxLines: 1))),

        //!
        const SizedBox(height: 10),
        RoundedContainer(
            containerPropertiesModel: ContainerPropertiesModel(
                height: 2,
                width: screenSize.width,
                alignment: Alignment.center,
                backColor: lockWidget,
                borderColor: lockWidget,
                shadowColor: lockWidget,
                rounded: 0,
                borderWidth: 0,
                widget: const SizedBox(),
                margin: const EdgeInsets.all(0))),

        //!
        const SizedBox(height: 10),
        Row(children: <Widget>[
          const SizedBox(width: 30),
          GeneralButton(
              text: 'Cancelar',
              onPressed: () {},
              color: blueLightGlobalColor,
              textColor: blackPanter),
          const Expanded(child: SizedBox()),
          GeneralButton(
              text: 'Crear',
              onPressed: () {},
              color: greenPrincipal,
              textColor: blackPanter),
          const SizedBox(width: 30),
        ])
      ]))),
    );
  }
}
