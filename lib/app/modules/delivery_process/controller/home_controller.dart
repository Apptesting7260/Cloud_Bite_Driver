import 'package:cloud_bites_driver/app/storage/storageServices.dart';
import 'package:cloud_bites_driver/app/themes/app_theme.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/custom_snakbar.dart';
import 'package:cloud_bites_driver/app/utils/repository/driver_socket_repository/driver_repository.dart';
import 'package:cloud_bites_driver/app/utils/service/sockets/socket_services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
    _initSocketListeners();
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
    final socketService = Get.find<SocketService>();

    socketService.socket.on('driverOnlineConfirmed', (data) {
      // This event confirms the driver is now online in the system
      isOnline.value = true;
      CustomSnackBar.show(message: 'You are now online and available for orders', color: AppTheme.primaryColor, tColor: AppTheme.white);
    });

    socketService.socket.on('driverOfflineConfirmed', (data) {
      // This event confirms the driver is now offline in the system
      isOnline.value = false;
      CustomSnackBar.show(message: 'You are now online and available for orders', color: AppTheme.primaryColor, tColor: AppTheme.white);
    });
  }

  void toggleOnlineStatus() async {
    if (isOnline.value) {
      // Going offline
      driverRepo.goOffline();
      isOnline.value = false;
    } else {
      // Going online - get current location first
      final currentLocation = await location.getLocation();
      driverRepo.goOnline(
        firstName: storageServices.getFirstName(),
        lastName: storageServices.getLastName(),
        fcmToken: storageServices.returnFCMToken(),
        latitude: currentLocation.latitude!,
        longitude: currentLocation.longitude!,
        address: storageServices.getAddress(),
      );
      isOnline.value = true;
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