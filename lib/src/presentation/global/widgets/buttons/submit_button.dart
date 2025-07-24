import 'package:flutter/material.dart';
import 'package:mantiz/src/presentation/pages/log_in/controller/log_in_controller.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../colors.dart';
import 'general_button.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LogInController>(context);
    if (controller.fetching) {
      return const CircularProgressIndicator();
    } else {
      return GeneralButton(
          text: 'Iniciar sesión',
          onPressed: () {
            final isValid = Form.of(context).validate();
            if (isValid) {
              _submit(context);
            }
          },
          color: blueNeutralGlobalColor,
          textColor: whiteGlobalColor);
    }
  }

  Future<void> _submit(BuildContext context) async {
    final controller = Provider.of<LogInController>(context, listen: false);
    controller.onFetchingChanged(true);

    final result =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .signIn(controller.username, controller.password);

    if (!controller.mounted) {
      return;
    }

    result.when(
      (failure) {
        controller.onFetchingChanged(false);
        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid credentials',
          SignInFailure.unknown: 'Error',
          SignInFailure.network: 'No internet'
        }[failure];

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
      },
      (userInfo) {
        Navigator.pushReplacementNamed(context, Routes.home);
      },
    );
  }
}
