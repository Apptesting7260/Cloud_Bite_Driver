import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.onboarding);
  }
}