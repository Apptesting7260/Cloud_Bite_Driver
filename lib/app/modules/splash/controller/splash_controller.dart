import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/routes/stage_navigator.dart';

class SplashController extends GetxController{
  final StorageServices storageService = Get.find<StorageServices>();

  @override
  void onInit() {
    super.onInit();
    checkAndAuth();
  }

  Future<void> checkAndAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final token = storageService.getToken();
      if (token != null && token.isNotEmpty) {
        StageNavigator.navigateToStage(storageService.getStages().toString());
      } else {
        await Get.offAllNamed(Routes.onboarding);
      }
    } catch (e) {
      print('Error during navigation: $e');
      await Get.offAllNamed(Routes.onboarding);
    }
  }
}