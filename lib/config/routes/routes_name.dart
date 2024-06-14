import 'package:bloc_mvc/config/routes/routes.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => Container());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => Container());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => Container());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
