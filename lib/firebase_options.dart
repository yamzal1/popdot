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
    apiKey: 'AIzaSyAKMdHWCt0BpaJgkAvR25MhS7QhuW-U3nk',
    appId: '1:170196836670:web:f38f5b0ca6b4575cb2cc6f',
    messagingSenderId: '170196836670',
    projectId: 'popdot-9c7f4',
    authDomain: 'popdot-9c7f4.firebaseapp.com',
    storageBucket: 'popdot-9c7f4.appspot.com',
    measurementId: 'G-W8YGFL5DXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUbUZZ-98FgVLgJ69au_nF-VbgGWntLcc',
    appId: '1:170196836670:android:8917ad915d7e2970b2cc6f',
    messagingSenderId: '170196836670',
    projectId: 'popdot-9c7f4',
    storageBucket: 'popdot-9c7f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj--Nnaly75TmpgOfOU9GsjDdG7r-EkdU',
    appId: '1:170196836670:ios:a041f5c201c7de31b2cc6f',
    messagingSenderId: '170196836670',
    projectId: 'popdot-9c7f4',
    storageBucket: 'popdot-9c7f4.appspot.com',
    iosClientId: '170196836670-b8onr9hk2bk442g5ouc1sv5ee6lsvv9e.apps.googleusercontent.com',
    iosBundleId: 'com.example.popdot',
  );
}
