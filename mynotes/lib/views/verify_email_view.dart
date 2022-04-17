import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification, please check your email"),
          TextButton(
            child: const Text("Haven't recieved an email? Send another"),
            onPressed: () async {
              await authProvider.sendEmailVerification();
            },
          ),
          TextButton(
            child: const Text('Restart'),
            onPressed: () async {
              await authProvider.logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
