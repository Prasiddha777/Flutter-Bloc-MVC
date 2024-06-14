import 'package:bloc_mvc/bloc/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget representing the submit button for the login form.
class LoginButton extends StatelessWidget {
  final formKey;
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                // context.read<LoginBloc>().add(LoginApi());
              }
            },
            child: const Text('Login'));
      },
    );
  }
}
