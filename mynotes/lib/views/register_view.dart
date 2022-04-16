import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                debugPrint('$userCredential');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  debugPrint('Weak Password');
                } else if (e.code == 'email-already-in-use') {
                  debugPrint('Email Already Exist');
                } else if (e.code == 'invalid-email') {
                  debugPrint('Invalid Email');
                } else {
                  debugPrint(e.code);
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login/',
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
