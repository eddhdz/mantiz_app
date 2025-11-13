import 'package:flutter/material.dart';

import '../../../global/colors.dart';
import '../../../global/widgets/texts/general_text.dart';
import '../controller/starting_point_controller.dart';

import 'package:provider/provider.dart';

class StartingPointView extends StatefulWidget {
  const StartingPointView({super.key});

  @override
  State<StartingPointView> createState() => _StartingPointViewState();
}

class _StartingPointViewState extends State<StartingPointView> {
  @override
  void initState() {
    super.initState();

    final vmInit = Provider.of<StartingPointController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vmInit.loadAllMaintenance(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StartingPointController>(context);

    return Scaffold(
        backgroundColor: sidonGreenDark,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text('MANTIZ',
                    style: TextStyle(
                      color: veryLightGray,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(height: 20),
              Center(
                  child: GeneralText(
                mensaje: vm.showMessage,
                maxLines: 2,
                overFlow: TextOverflow.ellipsis,
                size: 15,
                weight: FontWeight.bold,
                color: veryLightGray,
                align: TextAlign.center,
              )),
              const SizedBox(height: 20),
              (vm.isLoading)
                  ? const CircularProgressIndicator(color: veryLightGray)
                  : Container(),
              (vm.isLoading)
                  ? Container()
                  : IconButton(
                      onPressed: () async {
                        await vm.loadAllMaintenance(context);
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: veryLightGray,
                        size: 30,
                      ))
            ]));
  }
}
