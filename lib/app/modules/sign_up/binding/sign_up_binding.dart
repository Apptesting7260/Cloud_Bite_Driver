import 'package:cloud_bites_driver/app/core/app_exports.dart';


class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
          () => SignUpController(),
    );
  }
}
