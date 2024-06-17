import 'dart:async'; // Importing dart:async for asynchronous operations

import 'package:bloc_mvc/config/routes/routes.dart';
import 'package:bloc_mvc/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart'; // Importing Flutter material library

class SplashServices {
  void isLogin(BuildContext context) async {
    SessionController().getUserFromPreferences().then(
      (value) {
        if (SessionController().isLogin ?? false) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.home, (Route<dynamic> route) => false);
          });
        } else {
          Timer(const Duration(seconds: 3), () {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.login, (Route<dynamic> route) => false);
          });
        }
      },
    ).onError(
      (error, stackTrace) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (Route<dynamic> route) => false);
        });
      },
    );
  }
}
