import 'package:cloud_bites_driver/app/core/app_exports.dart';
class StageNavigator{
  static void navigateToStage(String stage) {
    switch (stage.toLowerCase()) {
      case '1':
        Get.offAllNamed(Routes.signUpScreen);
        break;
      case '2':
        Get.offAllNamed(Routes.deliveryMethodScreen);
        break;
      case '3':
        Get.offAllNamed(Routes.documentVerificationScreen);
        break;
      case '4':
        Get.offAllNamed(Routes.registrationCompleteScreen);
        break;
      default:
        Get.offAllNamed(Routes.onboarding);
    }
  }
}