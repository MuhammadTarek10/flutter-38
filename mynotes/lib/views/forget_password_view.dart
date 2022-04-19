import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/passwrod_reset_email_sent_dialog.dart';

class ForegetPasswordView extends StatefulWidget {
  const ForegetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForegetPasswordView> createState() => _ForegetPasswordViewState();
}

class _ForegetPasswordViewState extends State<ForegetPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
                context, 'We could not process your request!');
          }
        }
      }),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forget Password View'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('If you forgot your password, enter you email below'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Your email address...',
                ),
              ),
              TextButton(
                child: const Text('Send me a password reset link'),
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
              ),
              TextButton(
                  child: const Text('Back to login Page'),
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
