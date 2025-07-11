import 'package:firebase_core/firebase_core.dart';

import 'app/core/app_exports.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => NetworkService().init());

  await Get.putAsync(() => StorageServices().init());

  PushNotificationService.firebaseNotification();
  await Get.putAsync(() async => SocketController(),permanent: true);
  Get.put(DriverRepository());

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cloud Bites Driver",
        initialRoute: Routes.splash,
        getPages: Routes.routes,
        theme: AppTheme.lightTheme,
      ),
    ),
  );
}
