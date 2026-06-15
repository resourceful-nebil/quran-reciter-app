// Generated from android/app/google-services.json
// Re-run `flutterfire configure` after `firebase login` to regenerate for all platforms.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS — '
          'add an iOS app in Firebase Console and run flutterfire configure.',
        );
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACxvq_laHnA6_zpEhHvXvWvvGFaorxIII',
    appId: '1:375103586944:android:5be5cdd3d3e4be68009c65',
    messagingSenderId: '375103586944',
    projectId: 'quran-app-fa2f3',
    storageBucket: 'quran-app-fa2f3.firebasestorage.app',
  );
}
