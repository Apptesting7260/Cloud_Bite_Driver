import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PushNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String? fcmToken;

  static Future<void> firebaseNotification() async {
    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'CloudBites Vendor',
          channelDescription: 'channelDescription',
          importance: NotificationImportance.High,
          defaultColor: AppTheme.primaryColor,
          ledColor: AppTheme.primaryColor,
          playSound: true,
          enableLights: true,
          enableVibration: true,
        ),
      ],
      debug: true,
    );

    // Request permission for notifications
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;
      AppleNotification? appleNotification = notification?.apple;

      debugPrint('message notification body=====${message.notification?.body}');
      debugPrint('notification body=====$notification.  $android.   $appleNotification');

      if (notification != null) {
        showAwesomeNotification(notification.title ?? "", notification.body ?? "");
        debugPrint('notification shown with Awesome Notifications');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.notification != null) {
        debugPrint('App opened from notification');
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    getFcmTokenWithRetry();

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      debugPrint('Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint('Got APNs token: $token');
    }
  }

  static void showAwesomeNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecond,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        payload: {'customData': 'your_custom_data'},
      ),
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    WidgetDesigns.consoleLog("background notification--> ${message.notification?.body}", "bg notification");
  }

  static showCustomSnackBar(String title, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/launcher.webp',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.black),
                    maxLines: 1),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(color: AppTheme.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.boxBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: Get.height - (Get.height * 0.35),
          top: 0,
          left: 10,
          right: 10),
      dismissDirection: DismissDirection.up,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  static Future<String?> getFcmTokenWithRetry() async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        debugPrint("Retry: FCM token is null");
      } else {
        debugPrint("Retry: FCM token = $fcmToken");
      }
      return fcmToken;
    } catch (e) {
      WidgetDesigns.consoleLog("Retry error getting FCM token: $e", "Retry FCM Token Error");
      await Future.delayed(const Duration(seconds: 5));
      getFcmTokenWithRetry();
    }
  }
}
