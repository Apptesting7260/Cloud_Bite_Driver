import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SplashScreen extends StatelessWidget{

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black,
      ),
    );
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child:  CustomImageView(
        imageUrl: ImageConstants.splashImage,
        width: Get.width,
        height: Get.height,
      ),
    );
  }
}