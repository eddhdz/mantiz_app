import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/global/widgets/buttons/general_button.dart';

import '../../../global/colors.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  String _userName = '', _password = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              label: Text(
                                'Nombre de usuario',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              filled: true,
                              fillColor: blueExtraLightGlobalColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onChanged: (text) {
                            _userName = text.trim().toLowerCase();
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                filled: true,
                                fillColor: blueExtraLightGlobalColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onChanged: (text) {
                              _password =
                                  text.replaceAll(' ', '').toLowerCase();
                            },
                            validator: (value) {
                              value =
                                  value?.replaceAll(' ', '').toLowerCase() ??
                                      '';
                              if (value.length < 7) {
                                return 'Invalid Password';
                              }
                              return null;
                            }),
                        Builder(builder: (context) {
                          return GeneralButton(
                              text: 'Iniciar sesión',
                              onPressed: () {
                                final isValid = Form.of(context).validate();
                                if (isValid) {}
                              },
                              color: blueNeutralGlobalColor,
                              textColor: whiteGlobalColor);
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
