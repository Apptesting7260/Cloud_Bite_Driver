import 'package:get/get.dart';

import '../controllers/no_internet_connection_controller.dart';

class NoInternetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoInternetConnectionController>(
      () => NoInternetConnectionController(),
    );
  }
}
