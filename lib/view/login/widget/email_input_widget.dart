import 'package:bloc_mvc/bloc/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget representing the email input field.
class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode, // Setting focus node
          decoration: InputDecoration(
            icon: const Icon(Icons.email), // Icon for email input field
            // labelText:
            //     AppLocalizations.of(context)!.email, // Label text for email input field
            // helperText: AppLocalizations.of(context)!
            //     .aCompleteValidEmailExamplejoegmailcom, // Helper text for email input field
          ),
          keyboardType:
              TextInputType.emailAddress, // Setting keyboard type to email address
          onChanged: (value) {
            // Dispatching EmailChanged event when email input changes
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter email';
            }

            // if (value.emailValidator()) {
            //   return 'Email is not correct';
            // }
            // return null;
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
