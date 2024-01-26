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
    apiKey: 'AIzaSyAKWDHwKpBLys1y_wwO4vnd2ayb_7q68kk',
    appId: '1:389272778732:web:999b1d4b7aa89af58132c9',
    messagingSenderId: '389272778732',
    projectId: 'restaurant-app-2ff81',
    authDomain: 'restaurant-app-2ff81.firebaseapp.com',
    storageBucket: 'restaurant-app-2ff81.appspot.com',
    measurementId: 'G-K4MPW3FQHY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApPq3nDIZv9v9zWY3cq0mcfK3T0pOLNmQ',
    appId: '1:389272778732:android:40d27ca31079def38132c9',
    messagingSenderId: '389272778732',
    projectId: 'restaurant-app-2ff81',
    storageBucket: 'restaurant-app-2ff81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRgnDK1co9n3AQXi7OFVr_ndRWAiXifsQ',
    appId: '1:389272778732:ios:a1c14fd702b0b7b28132c9',
    messagingSenderId: '389272778732',
    projectId: 'restaurant-app-2ff81',
    storageBucket: 'restaurant-app-2ff81.appspot.com',
    iosBundleId: 'com.example.restaurantApp',
  );
}