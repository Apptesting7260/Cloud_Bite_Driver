import 'package:cloud_bites_driver/app/utils/flavor_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/core/app_exports.dart';
import 'app/utils/service/analytics_observer.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "cloudbitesbw-staging",
      options: DefaultFirebaseOptions.firebaseOptions(flavor: FlavorService().flavor));

  await Get.putAsync(() => FlavorService().init());
  await Get.putAsync(() => NetworkService().init());
  await Get.putAsync(() => StorageServices().init());
  PushNotificationService.firebaseNotification();
  await Get.putAsync(() async => SocketController(), permanent: true);
  debugPrint("baseurl of flavor is ${AppUrls.baseUrl}");
  Get.put(DriverRepository());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        navigatorObservers: [AnalyticsObserver()],
        debugShowCheckedModeBanner: false,
        title: "Cloud Bites Driver",
        initialRoute: Routes.splash,
        getPages: Routes.routes,
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    ),
  );
}
