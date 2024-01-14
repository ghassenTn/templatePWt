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
        return macos;
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
    apiKey: 'AIzaSyDvfNbXQR_ibDYfhKUjnvZw_-UW7Zkxa48',
    appId: '1:862159482323:web:8a65ce268f33cdc9855326',
    messagingSenderId: '862159482323',
    projectId: 'meublefirebase',
    authDomain: 'meublefirebase.firebaseapp.com',
    storageBucket: 'meublefirebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBI_gDDScpctBdpqYOKJWKvrb5VFjpzKeQ',
    appId: '1:862159482323:android:681c2887d08b2759855326',
    messagingSenderId: '862159482323',
    projectId: 'meublefirebase',
    storageBucket: 'meublefirebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKB4CoxCC1npn4OiPEDyOGWlbB6MHG4W8',
    appId: '1:862159482323:ios:346df3a3962bf40b855326',
    messagingSenderId: '862159482323',
    projectId: 'meublefirebase',
    storageBucket: 'meublefirebase.appspot.com',
    iosBundleId: 'com.example.ventemeuble',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKB4CoxCC1npn4OiPEDyOGWlbB6MHG4W8',
    appId: '1:862159482323:ios:3f5e944ebbb50c8b855326',
    messagingSenderId: '862159482323',
    projectId: 'meublefirebase',
    storageBucket: 'meublefirebase.appspot.com',
    iosBundleId: 'com.example.ventemeuble.RunnerTests',
  );
}
