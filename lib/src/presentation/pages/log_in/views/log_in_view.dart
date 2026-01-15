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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [sidonPrimaryColor, sidonSecondaryColor])),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
          child: Column(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'lib/src/assets/logos/mantiz_icono.png',
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Center(
                      child: Text(
                    'MANTIZ',
                    style: TextStyle(
                      color: sidonSecondaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                width: size.width * 0.9,
                height: size.height * 0.5,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: sidonSecondaryColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Form(
                  child: Builder(builder: (formcontext) {
                    return AbsorbPointer(
                      absorbing: controller.fetching,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                  color: sidonTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          buildTextFormField(
                            hintText: 'Usuario',
                            icon: Icons.person,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                icon: Icon(
                                  controller.isVisible
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: sidonPrimaryColor,
                                ),
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
                            color: sidonPrimaryColor,
                            textColor: sidonSecondaryColor,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
