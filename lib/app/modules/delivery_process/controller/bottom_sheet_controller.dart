import 'package:cloud_bites_driver/app/core/app_exports.dart';

enum BottomSheetState {
  none,
  lookingForOrders,
  newOrderArrived,
  acceptedOrderSheet,
  sendOtpSheet,
  orderPickedSheet,
  afterReadyForDeliveryBuild,
  orderDeliveredSheet
}

class BottomSheetController extends GetxController {
  final Rx<BottomSheetState> currentSheet = BottomSheetState.none.obs;
  final Rx<OrderModel?> currentOrder = Rx<OrderModel?>(null);
  final Rx<AcceptedOrderModel?> orderDetails = Rx<AcceptedOrderModel?>(null);
  Map<String, dynamic>? currentOrderData;

  void showLookingForOrders() {
    currentSheet.value = BottomSheetState.lookingForOrders;
  }

  void showNewOrder(OrderModel order,path) {
    currentOrder.value = order;
    currentSheet.value = BottomSheetState.newOrderArrived;
    if(path==""){
      Get.find<HomeController>().totalTime = getRemainingSeconds(order.expiryTime);
      Get.find<HomeController>().remainingTime.value = getRemainingSeconds(order.expiryTime);
      Get.find<HomeController>().startTimer();
    }
  }
  int getRemainingSeconds(String utcTimeString) {
    try {
      // Parse UTC time and convert to local
      DateTime targetLocal =
      DateTime.parse(utcTimeString).toLocal();

      DateTime now = DateTime.now();

      int remainingSeconds =
          targetLocal.difference(now).inSeconds;

      // If expired or negative
      if (remainingSeconds <= 0) {
        return 0;
      }

      // If more than 30 seconds
      if (remainingSeconds > 30) {
        return 30;
      }
print("remail seconds -----------${remainingSeconds}");
      return remainingSeconds;
    } catch (e) {
      // In case of invalid date string
      return 30;
    }
  }

  void acceptOrder() {
    final order = currentOrder.value;
    if (order != null) {
      Get.find<HomeController>().stopAcceptanceTimer();
      Get.find<HomeController>().acceptOrder(order.orderId.toString());
    }
  }

  void rejectOrder() {
    final order = currentOrder.value;
    if (order != null) {
      Get.find<HomeController>().rejectOrder(order.orderId.toString());
      // hideAllSheets();
      currentSheet.value = BottomSheetState.none;
      showLookingForOrders();
    }
  }

  // After Accept the Order
  void showAcceptedOrderDetails(AcceptedOrderModel details) {
    Get.find<HomeController>().stopAcceptanceTimer();
    orderDetails.value = details;
    currentSheet.value = BottomSheetState.acceptedOrderSheet;
  }

  void afterReadyForDeliveryBuild(){
    Get.find<HomeController>().stopAcceptanceTimer();
    currentSheet.value = BottomSheetState.afterReadyForDeliveryBuild;
  }

  // Otp Sheet
  // In BottomSheetController
  void showSendOtpSheet() {
    Get.find<HomeController>().stopAcceptanceTimer();
    currentSheet.value = BottomSheetState.sendOtpSheet;
  }

  // Verify Phone
  void showOrderPickedUp(){
    Get.find<HomeController>().stopAcceptanceTimer();
    currentSheet.value = BottomSheetState.orderPickedSheet;
  }

  void showOrderDelivered(){
    Get.find<HomeController>().stopAcceptanceTimer();
    currentSheet.value = BottomSheetState.orderDeliveredSheet;
  }

  void hideAllSheets() {
    Get.find<HomeController>().stopAcceptanceTimer();
    currentSheet.value = BottomSheetState.none;
    currentOrderData = null;
  }

  void timeoutOrder() {
    if (currentSheet.value == BottomSheetState.newOrderArrived) {
      final order = currentOrder.value;
      if (order != null) {
        currentOrder.value = null;
        currentSheet.value = BottomSheetState.lookingForOrders;
        CustomSnackBar.show(
          message: 'Order timed out',
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    }
  }
}
