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

  void showNewOrder(OrderModel order) {
    Get.find<HomeController>().resetAcceptanceTimer();
    currentOrder.value = order;
    currentSheet.value = BottomSheetState.newOrderArrived;
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
      hideAllSheets();
    }
  }

  // After Accept the Order
  void showAcceptedOrderDetails(AcceptedOrderModel details) {
    orderDetails.value = details;
    currentSheet.value = BottomSheetState.acceptedOrderSheet;
  }

  void afterReadyForDeliveryBuild(){
    currentSheet.value = BottomSheetState.afterReadyForDeliveryBuild;
  }

  // Otp Sheet
  // In BottomSheetController
  void showSendOtpSheet() {
    currentSheet.value = BottomSheetState.sendOtpSheet;
  }

  // Verify Phone
  void showOrderPickedUp(){
    currentSheet.value = BottomSheetState.orderPickedSheet;
  }

  void showOrderDelivered(){
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
