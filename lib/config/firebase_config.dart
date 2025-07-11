import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: _getFirebaseOptions(),
    );
  }

  static FirebaseOptions _getFirebaseOptions() {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "YOUR_WEB_API_KEY",
        authDomain: "to-buy-app.firebaseapp.com",
        projectId: "to-buy-app",
        storageBucket: "to-buy-app.appspot.com",
        messagingSenderId: "123456789",
        appId: "1:123456789:web:abc123def456",
      );
    }
    
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: "YOUR_ANDROID_API_KEY",
          appId: "1:123456789:android:abc123def456",
          messagingSenderId: "123456789",
          projectId: "to-buy-app",
          storageBucket: "to-buy-app.appspot.com",
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: "YOUR_IOS_API_KEY",
          appId: "1:123456789:ios:abc123def456",
          messagingSenderId: "123456789",
          projectId: "to-buy-app",
          storageBucket: "to-buy-app.appspot.com",
          iosBundleId: "com.tobuy.app.toBuy",
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform.',
        );
    }
  }
} 