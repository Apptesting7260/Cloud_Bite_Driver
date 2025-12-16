/*
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyD5YIiWRF7MeoibljbEMC4ORjs9v8xMNGw',
    appId: '1:524176041811:web:701d6724161682c27123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    authDomain: 'cloudbitesbw-51508.firebaseapp.com',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    measurementId: 'G-X8LSYG2GQM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDASK3pVdsSZTlXZ1Tqjt8Nbqy28NK4fKI',
    appId: '1:524176041811:android:0717e95bb352e8307123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6Y1d1Pad9skaz7JuiYFUrIlDNxBSl4OI',
    appId: '1:524176041811:ios:f86f72f0209101397123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    androidClientId: '524176041811-2vq7hpf091cc9mb83hnoul8tupbsse15.apps.googleusercontent.com',
    iosClientId: '524176041811-sbsdf49l6hjvpad819a2al2f8r37s3vn.apps.googleusercontent.com',
    iosBundleId: 'com.example.cloudBitesDriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6Y1d1Pad9skaz7JuiYFUrIlDNxBSl4OI',
    appId: '1:524176041811:ios:f86f72f0209101397123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    androidClientId: '524176041811-2vq7hpf091cc9mb83hnoul8tupbsse15.apps.googleusercontent.com',
    iosClientId: '524176041811-sbsdf49l6hjvpad819a2al2f8r37s3vn.apps.googleusercontent.com',
    iosBundleId: 'com.example.cloudBitesDriver',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5YIiWRF7MeoibljbEMC4ORjs9v8xMNGw',
    appId: '1:524176041811:web:95a593af08f832927123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    authDomain: 'cloudbitesbw-51508.firebaseapp.com',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    measurementId: 'G-B857SGYFX7',
  );
}
*/
/*
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDASK3pVdsSZTlXZ1Tqjt8Nbqy28NK4fKI',
    appId: '1:524176041811:android:26af037d16ae734d7123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6Y1d1Pad9skaz7JuiYFUrIlDNxBSl4OI',
    appId: '1:524176041811:ios:d8ea3ca6984839677123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    iosBundleId: 'com.cloudBites.user',
  );
}
*/

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// FlutterFire Firebase options with support for multiple flavors.
class DefaultFirebaseOptions {
  /// Get FirebaseOptions based on the current platform and flavor
  /// Pass `flavor` as 'staging' or 'prod'
  static FirebaseOptions firebaseOptions({required String flavor}) {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'use FlutterFire CLI to generate web options.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return flavor == 'staging' ? androidStaging : androidProd;
      case TargetPlatform.iOS:
        return flavor == 'staging' ? iosStaging : iosProd;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions not configured for desktop platforms.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ---------------- ANDROID ----------------
  static const FirebaseOptions androidProd = FirebaseOptions(
    apiKey: 'AIzaSyDASK3pVdsSZTlXZ1Tqjt8Nbqy28NK4fKI',
    appId: '1:524176041811:android:26af037d16ae734d7123a6',
    messagingSenderId: '24115167748',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
  );

  static const FirebaseOptions androidStaging = FirebaseOptions(
    apiKey: 'AIzaSyCpCwEyOPBVLWqf9pQSuB4Bu0fGL9_d7jQ', // same as prod or staging key
    appId: '1:24115167748:android:510f6cdb458810e04aeb51',       // replace with staging App ID
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-staging',
    storageBucket: 'cloudbitesbw-staging.firebasestorage.app',
  );

  // ---------------- IOS ----------------


  static const FirebaseOptions iosProd = FirebaseOptions(
    apiKey: 'AIzaSyD6Y1d1Pad9skaz7JuiYFUrIlDNxBSl4OI',
    appId: '1:524176041811:ios:d8ea3ca6984839677123a6',
    messagingSenderId: '524176041811',
    projectId: 'cloudbitesbw-51508',
    storageBucket: 'cloudbitesbw-51508.firebasestorage.app',
    iosBundleId: 'com.cloudBites.user',
  );

  static const FirebaseOptions iosStaging = FirebaseOptions(
    apiKey: 'AIzaSyD6Y1d1Pad9skaz7JuiYFUrIlDNxBSl4OI',
    appId: '1:24115167748:android:510f6cdb458810e04aeb51',  // replace with staging App ID
    messagingSenderId: '24115167748',
    projectId: 'cloudbitesbw-staging',
    storageBucket: 'cloudbitesbw-staging.firebasestorage.app',
    iosBundleId: 'com.cloudBites.user.staging',
  );
}
