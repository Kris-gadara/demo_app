import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// HOW TO SET UP FIREBASE:
/// 1. Go to https://console.firebase.google.com/
/// 2. Create a new project (e.g., "my-flutter-task-app")
/// 3. Add a Web app & Android app from Project Settings
/// 4. Copy each platform's config values into the fields below
/// 5. In Firebase Console -> Authentication -> Enable Email/Password & Anonymous
/// 6. In Firebase Console -> Firestore Database -> Create database (test mode)
///
/// OR run:  dart pub global activate flutterfire_cli && flutterfire configure
class DefaultFirebaseOptions {
  /// Returns true if Firebase credentials have been configured (not placeholders).
  static bool get isConfigured {
    try {
      final opts = currentPlatform;
      return !opts.apiKey.startsWith('YOUR_') &&
          !opts.projectId.startsWith('your-') &&
          opts.apiKey.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

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

  // ═══════════════════════════════════════════════════════════════════════════
  // Firebase project: myapp-2cbf3
  // Project number:   95109614238
  // ═══════════════════════════════════════════════════════════════════════════

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXB7BvcWPKXGHKFYo8cz4J2zaehw3s8qI',
    appId: '1:95109614238:web:4e1ab10db16569fdaa098f',
    messagingSenderId: '95109614238',
    projectId: 'myapp-2cbf3',
    authDomain: 'myapp-2cbf3.firebaseapp.com',
    storageBucket: 'myapp-2cbf3.firebasestorage.app',
    measurementId: 'G-FV9YMTCDVF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXB7BvcWPKXGHKFYo8cz4J2zaehw3s8qI',
    appId: '1:95109614238:android:4e1ab10db16569fdaa098f',
    messagingSenderId: '95109614238',
    projectId: 'myapp-2cbf3',
    storageBucket: 'myapp-2cbf3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXB7BvcWPKXGHKFYo8cz4J2zaehw3s8qI',
    appId: '1:95109614238:ios:4e1ab10db16569fdaa098f',
    messagingSenderId: '95109614238',
    projectId: 'myapp-2cbf3',
    storageBucket: 'myapp-2cbf3.firebasestorage.app',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXB7BvcWPKXGHKFYo8cz4J2zaehw3s8qI',
    appId: '1:95109614238:macos:4e1ab10db16569fdaa098f',
    messagingSenderId: '95109614238',
    projectId: 'myapp-2cbf3',
    storageBucket: 'myapp-2cbf3.firebasestorage.app',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXB7BvcWPKXGHKFYo8cz4J2zaehw3s8qI',
    appId: '1:95109614238:windows:4e1ab10db16569fdaa098f',
    messagingSenderId: '95109614238',
    projectId: 'myapp-2cbf3',
    storageBucket: 'myapp-2cbf3.firebasestorage.app',
  );
}

