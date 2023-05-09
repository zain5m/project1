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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRp9SNHohIR_IdJCSrDaYB2jpp84820WE',
    appId: '1:222530786892:web:20fc68fdb5fe93d93206e9',
    messagingSenderId: '222530786892',
    projectId: 'project11-9dcc0',
    authDomain: 'project11-9dcc0.firebaseapp.com',
    storageBucket: 'project11-9dcc0.appspot.com',
    measurementId: 'G-CNBZ27G8GE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKBJ9GrFwOHGvB1WUeGvN5mgZHsXkitEw',
    appId: '1:222530786892:android:f15419a5350bfbfb3206e9',
    messagingSenderId: '222530786892',
    projectId: 'project11-9dcc0',
    storageBucket: 'project11-9dcc0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiNxLmprakD7KTFJM62G9u8PjKeKjFpkI',
    appId: '1:222530786892:ios:d44e18b6c712e4403206e9',
    messagingSenderId: '222530786892',
    projectId: 'project11-9dcc0',
    storageBucket: 'project11-9dcc0.appspot.com',
    androidClientId: '222530786892-o4a8ap30q58b32fvj6cophh321obp7im.apps.googleusercontent.com',
    iosClientId: '222530786892-otd453igd13c830n2rpsm9br2souvo39.apps.googleusercontent.com',
    iosBundleId: 'com.example.project1',
  );
}
