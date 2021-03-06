// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA2RnjMQohNPeIKF87vXMRuqjxxZdkQ1IU',
    appId: '1:556738994672:web:e4ef4c4a3367f8ef7cbd35',
    messagingSenderId: '556738994672',
    projectId: 'mynotes-flutter-38',
    authDomain: 'mynotes-flutter-38.firebaseapp.com',
    storageBucket: 'mynotes-flutter-38.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdu0tGFiIRQ7BdkOL2PiCtafEo3WG5RCo',
    appId: '1:556738994672:android:4a943d1933bc201b7cbd35',
    messagingSenderId: '556738994672',
    projectId: 'mynotes-flutter-38',
    storageBucket: 'mynotes-flutter-38.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNujOS6CglnS_S4C48jwyOfUe0xhHc7tE',
    appId: '1:556738994672:ios:b3332010b35ec7007cbd35',
    messagingSenderId: '556738994672',
    projectId: 'mynotes-flutter-38',
    storageBucket: 'mynotes-flutter-38.appspot.com',
    iosClientId: '556738994672-8391t82cmbtfmsroe7ctejnfupbllubh.apps.googleusercontent.com',
    iosBundleId: 'camp.flutter.course.mynotes',
  );
}
