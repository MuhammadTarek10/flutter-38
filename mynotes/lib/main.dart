import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return BlocProvider(
        create: (context) => CounterBloc(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Hello bloc')),
          body: BlocConsumer<CounterBloc, CounterState>(
            listener: (context, state) {
              _controller.clear();
            },
            builder: (context, state) {
              final invalidValue = (state is CounterStateInvalidNumber)
                  ? state.invalidValue
                  : '';
              return Column(
                children: [
                  Text('Current value is: ${state.value}'),
                  Visibility(
                    child: Text('Invalid input: $invalidValue'),
                    visible: state is CounterStateInvalidNumber,
                  ),
                  TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Enter a number here!'),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text('-'),
                        onPressed: () {
                          context.read<CounterBloc>().add(
                                DecrementEvent(_controller.text),
                              );
                        },
                      ),
                      TextButton(
                        child: const Text('+'),
                        onPressed: () {
                          context.read<CounterBloc>().add(
                                IncrementEvent(_controller.text),
                              );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(
    int value,
  ) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(
    String value,
  ) : super(value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(
    String value,
  ) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncrementEvent>(((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidNumber(
              invalidValue: event.value, previousValue: state.value),
        );
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    }));
    on<DecrementEvent>(((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidNumber(
              invalidValue: event.value, previousValue: state.value),
        );
      } else {
        emit(
          CounterStateValid(state.value - integer),
        );
      }
    }));
  }
}

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   final authProvider = AuthService.firebase();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: authProvider.initialize(),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final user = authProvider.currentUser;
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 return const NotesView();
//               }
//               return const VerifyEmailVeiw();
//             }
//             return const LoginView();
//           default:
//             return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
