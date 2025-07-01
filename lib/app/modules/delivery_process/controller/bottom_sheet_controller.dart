import 'package:cloud_bites_driver/app/core/app_exports.dart';

enum BottomSheetState {
  none,
  lookingForOrders,
  newOrderArrived,
  orderDetails,
}

class BottomSheetController extends GetxController {
  final Rx<BottomSheetState> currentSheet = BottomSheetState.none.obs;
  final Rx<OrderModel?> currentOrder = Rx<OrderModel?>(null);
  Map<String, dynamic>? currentOrderData;

  void showLookingForOrders() {
    currentSheet.value = BottomSheetState.lookingForOrders;
  }

  void showNewOrder(OrderModel order) {
    currentOrder.value = order;
    currentSheet.value = BottomSheetState.newOrderArrived;
  }

  void showOrderDetails(Map<String, dynamic> orderData) {
    currentOrderData = orderData;
    currentSheet.value = BottomSheetState.orderDetails;
  }

  void hideAllSheets() {
    currentSheet.value = BottomSheetState.none;
    currentOrderData = null;
  }
}
