import 'dart:async';

import 'package:cloud_bites_driver/app/constants/socket_url.dart';
import 'package:cloud_bites_driver/app/core/app_exports.dart'
    show FormState, GlobalKey, TextEditingController;
import 'package:cloud_bites_driver/app/modules/delivery_process/controller/bottom_sheet_controller.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/accepted_order_model.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/order_model.dart'
    show OrderModel;
import 'package:cloud_bites_driver/app/storage/storageServices.dart';
import 'package:cloud_bites_driver/app/themes/app_theme.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/custom_snakbar.dart';
import 'package:cloud_bites_driver/app/utils/repository/driver_socket_repository/driver_repository.dart';
import 'package:cloud_bites_driver/app/utils/service/sockets/socket_services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  GoogleMapController? mapController;
  Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);
  final RxBool isOnline = false.obs;
  var socketService = Get.find<SocketController>();

  final DriverRepository driverRepo = Get.find<DriverRepository>();
  final Location location = Location();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;
  final RxBool isSocketConnecting = false.obs;
  final RxString connectionStatus = 'Disconnected'.obs;
  final Rx<AcceptedOrderModel?> orderDetails = Rx<AcceptedOrderModel?>(null);

  TextEditingController otpController = TextEditingController();
  var isSlid = false.obs;

  void onSlideCompleted() {
    isSlid.value = true;
  }

  // For Remaining Time
  final RxInt remainingTime = 30.obs;
  final int totalTime = 30;
  late Timer _timer;

  void startTimer() {
    remainingTime.value = totalTime;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        stopTimer();
        // Notify server about timeout
        final order = bottomSheetController.currentOrder.value;
        if (order != null) {
          Get.find<DriverRepository>().timeoutOrder(order.orderId.toString());
        }
        bottomSheetController.timeoutOrder();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  final BottomSheetController bottomSheetController = Get.put(
    BottomSheetController(),
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // for otp event----
  final RxString otpPhoneNumber = ''.obs;
  final RxString otpCode = ''.obs;

  void sendOtp() {
    final orderDetails = bottomSheetController.orderDetails.value;
    if (orderDetails != null) {
      driverRepo.sendOTP(
        orderDetails.data?.orderDetail?.orderdata?.id.toString() ?? '',
      );
      bottomSheetController.showSendOtpSheet();
    }
  }

  void getCurrentOrderDetailsEvent() {
    final driverId = storageServices.getDriverID();
    print("getCurrentOderDetails----------$driverId");
    socketService.sendMessage(SocketEvents.getCurrentOrderDetails, {
      "driverId": driverId,
    });
    socketService.listenToEvent(SocketEvents.getCurrentOrderDetails, (p0) {
      print("get current order detial------------- $p0");
      socketService.off(SocketEvents.getCurrentOrderDetails);
      if (p0['status']) {}
    });
  }

  void driverIsOnline() {
    final driverId = storageServices.getDriverID();
    socketService.sendMessage("is_online", {"driverId": driverId});
    socketService.listenToEvent("is_online", (p0) {
      print("Driver isOnline---------$p0");
      if (p0['status']) {}
    });
  }

  void verifyOtp() {
    final orderDetails = bottomSheetController.orderDetails.value;
    if (orderDetails != null) {
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.sendOTP, {
        'driverid': driverId,
        'orderId':
            orderDetails.data?.orderDetail?.orderdata?.id.toString() ?? '',
        'action': 'verify',
        'otp': '${otpController.text}',
      });

      socketService.listenToEvent(SocketEvents.sendOTP, (data) {
        print("otp ----------${otpController.text}");
        socketService.off(SocketEvents.sendOTP);
        if (data['status']) {
          otpController.clear();
          if (data["isCompleted"]==true) {
            bottomSheetController.showOrderDelivered();
          } else {
            bottomSheetController.showOrderPickedUp();
          }
        } else {
          print("data ${data}");
        }
        print('✅ Send Otp Received $data');
        CustomSnackBar.show(
          message: data['message'],
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      });
    }
  }

  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  final resendEnabled = false.obs;
  final remainingTimer = 60.obs;
  Timer? resendTime;

  void startResendTimer() {
    resendEnabled.value = false;
    remainingTimer.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimer.value > 0) {
        remainingTimer.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startResendTimer();
  }

  @override
  void onInit() {
    super.onInit();
    driverRepo.joinDriver();
    driverIsOnline();
    _getUserLocation();
    _initSocketListeners();
    driverRepo.listenForNewOrders();

    // Listen for new orders
    ever(driverRepo.currentOrder, (OrderModel? order) {
      if (order != null) {
        bottomSheetController.showNewOrder(order);
      }
    });

    // Listen for accepted order
    ever(driverRepo.orderDetails, (AcceptedOrderModel? details) {
      if (details != null) {
        bottomSheetController.showAcceptedOrderDetails(details);
      }
    });

    /*final socketService = Get.find<SocketService>();
    if (socketService.isConnected.value) {
      joinDriverEvent();
    }*/
  }

  Future<void> _getUserLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    final userLocation = await location.getLocation();

    initialCameraPosition.value = CameraPosition(
      target: LatLng(userLocation.latitude!, userLocation.longitude!),
      zoom: 14.0,
    );
  }

  // Socket Code

  void _initSocketListeners() {
    /*socketService.listenToEvent(SocketEvents.connect, (_) {
      print('🔌 onConnect triggered in HomeController');
      //joinDriverEvent();
    });*/

    socketService.listenToEvent(SocketEvents.goOnline, (data) {
      isOnline.value = true;
      print('✅ Received driverOnlineConfirmed, showing bottom sheet${data}');
      print(
        '✅ Received driverOnlineConfirmed, showing bottom sheet${isOnline.value}',
      );
      bottomSheetController.showLookingForOrders();
    });

    socketService.listenToEvent(SocketEvents.goOffline, (data) {
      isOnline.value = false;
      print('✅ Received driverOfflineConfirmed, hiding bottom sheet');
      bottomSheetController.hideAllSheets();
      CustomSnackBar.show(
        message: 'You are now offline',
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
    });

    socketService.listenToEvent(SocketEvents.joinDriver, (data) {
      //isOnline.value = true;
      print('✅ Join Driver Received $data');
      CustomSnackBar.show(
        message: 'Joined Driver',
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
    });

    socketService.listenToEvent(SocketEvents.acceptedOrderScreen, (data) {
      print('✅ acceptedOrderScreen $data');
      try {
        final orderDetails = AcceptedOrderModel.fromJson(data);
        bottomSheetController.orderDetails.value = orderDetails;
        bottomSheetController.orderDetails.refresh();
        if (orderDetails.data?.pickUp == false) {
          bottomSheetController.showAcceptedOrderDetails(orderDetails);
        } else {
          final orderModel = OrderModel(
            orderId: orderDetails.data?.orderDetail?.orderdata?.id ?? "",
            vendorId: orderDetails.data?.orderDetail?.vendordata?.id ?? "",
            orderNumber:
                orderDetails.data?.orderDetail?.orderdata?.orderId ?? "",
            quantity: orderDetails.data?.orderDetail?.orderdata?.quantity ?? "",
            totalAmount:
                orderDetails.data?.orderDetail?.orderdata?.totalAmount ?? "",
            deliveryTime:
                orderDetails.data?.orderDetail?.orderdata?.deliveryTime ?? '',
            restaurantName:
                orderDetails.data?.orderDetail?.vendordata?.restaurantName ??
                "",
            vendorAddress:
                orderDetails.data?.orderDetail?.vendordata?.address ?? "",
            vendorLatitude:
                orderDetails.data?.orderDetail?.vendordata?.latitude ?? 0.0,
            vendorLongitude:
                orderDetails.data?.orderDetail?.vendordata?.longitude ?? 0.0,
            userAddress:
                orderDetails
                    .data
                    ?.orderDetail
                    ?.userAddressData
                    ?.completeAddress ??
                "",
            userLatitude:
                orderDetails.data?.orderDetail?.userAddressData?.latitude ??
                0.0,
            userLongitude:
                orderDetails.data?.orderDetail?.userAddressData?.longitude ??
                0.0,
            pickupDistance: orderDetails.data?.pickUpLocation?.distance ?? "",
            pickupDuration: orderDetails.data?.pickUpLocation?.duration ?? "",
            deliveryDistance:
                orderDetails.data?.deliveryLocation?.distance ?? "",
            deliveryDuration:
                orderDetails.data?.deliveryLocation?.duration ?? "",
          );
          bottomSheetController.showNewOrder(orderModel);
        }
        // socketService.off(SocketEvents.acceptedOrderScreen);
      } catch (e) {
        print('Error parsing order details: $e');
      }
    });

    socketService.listenToEvent(SocketEvents.otpPhoneNo, (data) {
      print('✅ OTP Phone Received: $data');
      if (data is Map && data['phoneNumber'] != null) {
        final phone = data['phoneNumber'].toString();
        otpPhoneNumber.value = phone;
        print('📱 Phone number set: $phone');
      } else {
        print('⚠️ Invalid phone number format');
      }
    });
    socketService.listenToEvent(SocketEvents.newOrder, (data) {
      print('Raw newOrder data: $data');
      if (data is Map<String, dynamic>) {
        driverRepo.currentOrder.value = OrderModel.fromJson(data);
        print(
          'New order received: ${driverRepo.currentOrder.value?.orderNumber}',
        );
      } else {
        print(
          'Invalid order data format - Expected Map but got ${data.runtimeType}',
        );
      }
    });

    // driverRepo.listenForNewOrders();
  }

  void readyForDeliveryEvent() {
    final driverId = storageServices.getDriverID();

    socketService.sendMessage("readyForDelivery", {
      "orderId": orderDetails.value?.data?.orderDetail?.orderdata?.id ?? "",
      "driverId": driverId,
    });
    bottomSheetController.afterReadyForDeliveryBuild();
    socketService.listenToEvent("readyForDelivery", (p0) {
      print("object");
    });
  }

  Future<void> toggleOnlineStatus() async {
    try {
      if (isOnline.value) {
        // Emit offline request
        await driverRepo.goOffline();
        // UI will update when socket confirms via `driverOfflineConfirmed`
      } else {
        final currentLocation = await location.getLocation();
        await driverRepo.goOnline(
          firstName: storageServices.getFirstName(),
          lastName: storageServices.getLastName(),
          fcmToken: storageServices.returnFCMToken(),
          latitude: currentLocation.latitude!,
          longitude: currentLocation.longitude!,
          address: storageServices.getAddress(),
        );
        /*driverRepo.listenForNewOrders();*/
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinDriverEvent() async {
    try {
      await driverRepo.joinDriver();
      print('-------Driver Joined--------');
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    socketService.off('driverOnlineConfirmed');
    socketService.off('driverOfflineConfirmed');
    super.onClose();
  }
}
