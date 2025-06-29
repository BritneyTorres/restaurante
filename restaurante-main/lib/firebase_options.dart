// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
///
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
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
        return windows;
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
    apiKey: 'AIzaSyCKsEzPUdy7KQPcmJzTjuvBT9Bnz1jfTjk',
    appId: '1:6440611821:web:4ce602ccc67129abdd41e4',
    messagingSenderId: '6440611821',
    projectId: 'restaurante-k-df48d',
    authDomain: 'restaurante-k-df48d.firebaseapp.com',
    storageBucket: 'restaurante-k-df48d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAarVYaJJPyDtMRkkif2SWCwyJScIORTdA',
    appId: '1:6440611821:android:155d60d27eeee2dbdd41e4',
    messagingSenderId: '6440611821',
    projectId: 'restaurante-k-df48d',
    storageBucket: 'restaurante-k-df48d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd_Sq4Cd8Yc4BCUXCZ6POGS8VF9lmeO5o',
    appId: '1:6440611821:ios:a3a2c0179fba94e5dd41e4',
    messagingSenderId: '6440611821',
    projectId: 'restaurante-k-df48d',
    storageBucket: 'restaurante-k-df48d.firebasestorage.app',
    iosBundleId: 'com.example.flutterNuevo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCd_Sq4Cd8Yc4BCUXCZ6POGS8VF9lmeO5o',
    appId: '1:6440611821:ios:a3a2c0179fba94e5dd41e4',
    messagingSenderId: '6440611821',
    projectId: 'restaurante-k-df48d',
    storageBucket: 'restaurante-k-df48d.firebasestorage.app',
    iosBundleId: 'com.example.flutterNuevo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKsEzPUdy7KQPcmJzTjuvBT9Bnz1jfTjk',
    appId: '1:6440611821:web:d50f3827181101eddd41e4',
    messagingSenderId: '6440611821',
    projectId: 'restaurante-k-df48d',
    authDomain: 'restaurante-k-df48d.firebaseapp.com',
    storageBucket: 'restaurante-k-df48d.firebasestorage.app',
  );

}