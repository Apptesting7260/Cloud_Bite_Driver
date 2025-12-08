import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/my_profile_sub_screen_controller/payment_method_controller.dart';

class PaymentMethodBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PaymentMethodController(),);
  }
}