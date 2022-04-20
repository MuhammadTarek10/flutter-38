import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

class VerifyEmailVeiw extends StatefulWidget {
  const VerifyEmailVeiw({Key? key}) : super(key: key);

  @override
  State<VerifyEmailVeiw> createState() => _VerifyEmailVeiwState();
}

class _VerifyEmailVeiwState extends State<VerifyEmailVeiw> {
  final authProvider = AuthService.firebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.verify_email,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              context.loc.verify_email_view_prompt,
            ),
            TextButton(
              child: Text(
                context.loc.verify_email_send_email_verification,
              ),
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
            ),
            TextButton(
              child: Text(
                context.loc.restart,
              ),
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
