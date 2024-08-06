import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/buttons/general_button.dart';
import '../../../routes/routes.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteGlobalColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset('lib/src/assets/offline.jpg'),
            ),
            const Column(
              children: [
                Text(
                  'NO INTERNET',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Por favor revisa tu conexión e intenta de nuevo',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                )
              ],
            ),
            GeneralButton(
              text: 'Intentar de nuevo',
              textColor: Colors.black,
              color: blueStrongGlobalColor,
              onPressed: () async {
                final injector = Injector.of(context);
                final connectivityRepository = injector.connectivityRepository;
                final hasInternet = await connectivityRepository.hasInternet;
                if (hasInternet) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, Routes.splash);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
