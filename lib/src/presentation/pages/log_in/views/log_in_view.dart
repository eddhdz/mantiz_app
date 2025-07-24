import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/buttons/submit_button.dart';

import '../../../global/colors.dart';
import '../controller/log_in_controller.dart';

import 'package:provider/provider.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<LogInController>(
      create: (_) => LogInController(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [blueLightGlobalColor, blueStrongGlobalColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            SafeArea(
              child: Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                      color: whiteGlobalColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      child: Builder(builder: (context) {
                        final controller =
                            Provider.of<LogInController>(context);
                        return AbsorbPointer(
                          absorbing: controller.fetching,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    label: Text(
                                      'Nombre de usuario',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    filled: true,
                                    fillColor: blueExtraLightGlobalColor,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (text) {
                                  controller.onUserNameChanged(text);
                                },
                                validator: (value) {
                                  value = value?.trim().toLowerCase() ?? '';
                                  if (value.isEmpty) {
                                    return 'Invalid Username';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      label: Text('Contraseña',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      filled: true,
                                      fillColor: blueExtraLightGlobalColor,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  onChanged: (text) {
                                    controller.onPasswordChanged(text);
                                  },
                                  validator: (value) {
                                    value = value?.replaceAll(' ', '') ?? '';
                                    if (value.length < 3) {
                                      return 'Invalid Password';
                                    }
                                    return null;
                                  }),
                              const SubmitButton()
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
