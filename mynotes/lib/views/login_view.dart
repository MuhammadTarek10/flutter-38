import 'package:flutter/material.dart';
import 'package:mynotes/exceptions/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/utilities/dialogs/loading_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  final authProvider = AuthService.firebase();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundException) {
            await showErrorDialog(context, 'User Not Found');
          } else if (state.exception is WrongPasswordAuthException ||
              state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Wrong Credintials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login View')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please Login'),
              TextField(
                  controller: _email,
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress),
              TextField(
                controller: _password,
                decoration: const InputDecoration(hintText: 'Enter Passwrodl'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(AuthEventLogIn(
                              email,
                              password,
                            ));
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventShouldRegister());
                      },
                      child:
                          const Text('Not Registered? create an Account here!'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventForgotPassword());
                      },
                      child: const Text('Forgot Password? Click here!'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
