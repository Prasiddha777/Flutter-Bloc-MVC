import 'package:bloc_mvc/services/splash_services.dart';
import 'package:flutter/material.dart';

/// A widget representing the splash screen of the application.
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

/// The state of the [SplashView] widget.
class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();
  // @override
  void initState() {
    super.initState();
    // Calls the [checkAuthentication] method from [SplashServices] to handle authentication logic
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          // Displays the localized text for the splash screen
          // AppLocalizations.of(context)!.splashScreen,
          // style: Theme.of(context)
          //     .textTheme
          //     .displayMedium, // Applies the displayMedium text style from the current theme
        ),
      ),
    );
  }
}
