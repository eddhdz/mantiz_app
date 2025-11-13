import 'package:flutter/material.dart';

import '../../../global/colors.dart';
import '../../../global/widgets/buttons/general_button.dart';
import '../../../global/widgets/textFormField/helper_text_form_field.dart';
import '../controller/log_in_controller.dart';

import 'package:provider/provider.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Provider.of<LogInController>(context);

    return Scaffold(
      backgroundColor: sidonGreenDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: const BoxDecoration(
                color: sidonGreenDark,
              ),
              child: const Center(
                  child: Text(
                'MANTIZ',
                style: TextStyle(
                  color: veryLightGray,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: veryLightGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Form(
                child: Builder(builder: (formcontext) {
                  return AbsorbPointer(
                    absorbing: controller.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        buildTextFormField(
                          hintText: 'Usuario',
                          icon: Icons.person,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (user) =>
                              controller.onUserNameChanged(user),
                          validator: (user) {
                            user = user?.trim().toLowerCase() ?? '';
                            if (user.isEmpty) {
                              return 'Este campo no puede estar vacío';
                            }
                            return null;
                          },
                        ),
                        buildTextFormField(
                            hintText: 'Contraseña',
                            icon: Icons.lock_open_rounded,
                            obscureText: !controller.isVisible,
                            suffixIcon: IconButton(
                              onPressed: () => controller.onVisibleChanged(),
                              icon: Icon(controller.isVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (password) =>
                                controller.onPasswordChanged(password),
                            validator: (password) {
                              password = password?.replaceAll(' ', '') ?? '';
                              if (password.length < 3) {
                                // Minimum 6 characters is standard
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            }),
                        GeneralButton(
                          text: 'Iniciar sesión',
                          color: sidonGreenDark,
                          textColor: veryLightGray,
                          onPressed: () {
                            final isValid = Form.of(formcontext).validate();
                            if (isValid) {
                              controller.submitLogin(context);
                            }
                          },
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
