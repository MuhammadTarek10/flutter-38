import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/create_update_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Notes Flutter 38 Course',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailVeiw(),
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final authProvider = AuthService.firebase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authProvider.initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = authProvider.currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              }
              return const VerifyEmailVeiw();
            }
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
