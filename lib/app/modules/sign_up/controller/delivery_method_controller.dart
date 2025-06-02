import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DeliveryMethodController extends GetxController{

  var selectedOptionIndex = 0.obs;

  void selectOption(int index) {
    selectedOptionIndex.value = index;
  }
}