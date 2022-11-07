import 'package:e_con/core/app/settings.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/utils/observer.dart';
import 'package:e_con/src/presentations/login/login_page.dart';
import 'package:e_con/src/presentations/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EconApp extends StatelessWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Palette.background,
        statusBarColor: Palette.primaryVariant,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppSettings.title,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const SplashPage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoute.login:
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case AppRoute.wrapper:
            return MaterialPageRoute(builder: (_) => const LoginPage());
        }
        return null;
      },
    );
  }
}
