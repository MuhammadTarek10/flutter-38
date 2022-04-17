import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Register View')),
      body: Column(
        children: [
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
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await authProvider.createUser(
                    email: email, password: password);
                devtools.log(userCredential.toString());
                await authProvider.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak Password');
              } on EmailAlreadyExistedException {
                await showErrorDialog(context, 'Email Already Exists');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid Email');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already have an account? Login Here'),
          ),
        ],
      ),
    );
  }
}
