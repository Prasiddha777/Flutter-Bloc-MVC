import 'package:bloc_mvc/bloc/login/bloc/login_bloc.dart';
import 'package:bloc_mvc/config/routes/routes.dart';
import 'package:bloc_mvc/utils/enums.dart';
import 'package:bloc_mvc/utils/extensions/flush_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget representing the submit button for the login form.
class LoginButton extends StatelessWidget {
  final formKey;
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (previous, current) => previous.postApiStatus != current.postApiStatus,
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          print('I AM HERE ');
          // print(state.error);
          // context.flushBarErrorMessage(message: state.error.toString());
        } else if (state.postApiStatus == PostApiStatus.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (previous, current) => previous.postApiStatus != current.postApiStatus,
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginApi());
                }
              },
              child: state.postApiStatus == PostApiStatus.loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'));
        },
      ),
    );
  }
}
