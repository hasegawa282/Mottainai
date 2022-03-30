// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDutdgcv03LVL015dPaLvnWNdivSJQdMUQ',
    appId: '1:380548253862:web:cac0be2aec601ccd690c67',
    messagingSenderId: '380548253862',
    projectId: 'sc-ynu-2022',
    authDomain: 'sc-ynu-2022.firebaseapp.com',
    storageBucket: 'sc-ynu-2022.appspot.com',
    measurementId: 'G-ZM5MEH5CZD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA32qES5uA9SjtGe07lw_Z6bgrgZLbcNFw',
    appId: '1:380548253862:android:d9cd1e88ab843bb0690c67',
    messagingSenderId: '380548253862',
    projectId: 'sc-ynu-2022',
    storageBucket: 'sc-ynu-2022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe5QDOUFDg958mpB8yV1Jlks0nDFCBFc4',
    appId: '1:380548253862:ios:caa2ec3aa7de313a690c67',
    messagingSenderId: '380548253862',
    projectId: 'sc-ynu-2022',
    storageBucket: 'sc-ynu-2022.appspot.com',
    iosClientId: '380548253862-fbn7tvo650m7kfmvpt4uu8gi6ve0p9k0.apps.googleusercontent.com',
    iosBundleId: 'com.example.scYnuV1',
  );
}
