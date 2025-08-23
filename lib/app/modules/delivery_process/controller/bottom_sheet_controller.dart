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
      Get.find<HomeController>().startTimer();
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
