import 'package:flutter/material.dart';

import 'features/splash/splash_page.dart';

class BarbershopApp extends StatelessWidget {

  const BarbershopApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return MaterialApp(
        title: 'DW Barbershop',
        routes: {
          '/': (_) => const SplashPage()
        },
       );
  }
}