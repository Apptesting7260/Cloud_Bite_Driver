import 'dart:async';

import 'package:cloud_bites_driver/app/modules/delivery_process/controller/bottom_sheet_controller.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/order_model.dart' show OrderModel;
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


class HomeController extends GetxController{
  GoogleMapController? mapController;
  Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);
  final RxBool isOnline = false.obs;
  final DriverRepository driverRepo = Get.find<DriverRepository>();
  final Location location = Location();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;
  final RxBool isSocketConnecting = false.obs;
  final RxString connectionStatus = 'Disconnected'.obs;

  // For Remaining Time
  final RxInt remainingTime = 30.obs; // Starting from 30 seconds
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
  final BottomSheetController bottomSheetController = Get.put(BottomSheetController());

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
    _initSocketListeners();
    _checkSocketConnection();

    // Listen for new orders
    ever(driverRepo.currentOrder, (OrderModel? order) {
      if (order != null) {
        bottomSheetController.showNewOrder(order);
      }
    });

    final socketService = Get.find<SocketService>();
    if (socketService.isConnected.value) {
      joinDriverEvent();
    }
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
  void _checkSocketConnection() {
    final socketService = Get.find<SocketService>();

    // Bind to socket connection states
    isSocketConnecting.bindStream(socketService.isConnecting.stream);

    ever(socketService.isConnected, (connected) {
      connectionStatus.value = connected ? 'Connected' : 'Disconnected';

      if (!connected) {
        CustomSnackBar.show(
          message: 'Connection lost. Reconnecting...',
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      } else {
        CustomSnackBar.show(
          message: 'Connected to server',
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
        joinDriverEvent();
      }
    });
  }

  void _initSocketListeners() {
    final socketService = Get.find<SocketService>();

    socketService.socket.on('connect', (_) {
      print('🔌 onConnect triggered in HomeController');
      joinDriverEvent();
    });

    socketService.socket.on('goOnline', (data) {
      isOnline.value = true;
      print('✅ Received driverOnlineConfirmed, showing bottom sheet');
      bottomSheetController.showLookingForOrders();
    });

    socketService.socket.on('goOffline', (data) {
      isOnline.value = false;
      print('✅ Received driverOfflineConfirmed, hiding bottom sheet');
      bottomSheetController.hideAllSheets();
      CustomSnackBar.show(
        message: 'You are now offline',
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
    });
    
    socketService.socket.on('joinDriver', (data){
      isOnline.value = true;
      print('✅ Join Driver Received');
      bottomSheetController.hideAllSheets();
      CustomSnackBar.show(message: 'Joined Driver', color: AppTheme.primaryColor,
        tColor: AppTheme.white);
    });

    socketService.socket.on('acceptedOrderScreen', (data){
      print('✅ acceptedOrderScreen $data');
      CustomSnackBar.show(message: 'acceptedOrderScreen', color: AppTheme.primaryColor,
          tColor: AppTheme.white);
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
        driverRepo.listenForNewOrders();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinDriverEvent() async {
    try {
      await driverRepo.joinDriver();
    } catch (e) {
      print(e);
    }
  }


  @override
  void onClose() {
    final socketService = Get.find<SocketService>();
    socketService.socket.off('driverOnlineConfirmed');
    socketService.socket.off('driverOfflineConfirmed');
    super.onClose();
  }
}