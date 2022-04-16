import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login View')),
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
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                debugPrint('$userCredential');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  debugPrint('User not Found');
                } else {
                  debugPrint('$e something baaaaad happendddd');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register/',
                (route) => false,
              );
            },
            child: const Text('Not Registered? create an Account here!'),
          )
        ],
      ),
    );
  }
}
