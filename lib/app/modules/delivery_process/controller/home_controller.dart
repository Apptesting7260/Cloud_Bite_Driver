import 'dart:async';
import 'dart:math';

import 'package:cloud_bites_driver/app/constants/image_constants.dart';
import 'package:cloud_bites_driver/app/constants/socket_url.dart';
import 'package:cloud_bites_driver/app/core/app_exports.dart'
    show
        AlertDialog,
        ApiResponse,
        AppLifecycleState,
        Color,
        ExtensionDialog,
        FormState,
        Geolocator,
        GetNavigation,
        GlobalKey,
        ImageConfiguration,
        LocationSettings,
        Offset,
        Placemark,
        Position,
        Repository,
        Size,
        Text,
        TextButton,
        TextEditingController,
        TextEditingControllerller,
        WidgetDesigns,
        WidgetsBinding,
        placemarkFromCoordinates;
import 'package:cloud_bites_driver/app/modules/delivery_process/controller/bottom_sheet_controller.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/accepted_order_model.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/order_model.dart'
    show OrderModel;
import 'package:cloud_bites_driver/app/modules/my_profile/model/get_driver_data_model.dart';
import 'package:cloud_bites_driver/app/storage/storageServices.dart';
import 'package:cloud_bites_driver/app/themes/app_theme.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/custom_snakbar.dart';
import 'package:cloud_bites_driver/app/utils/repository/driver_socket_repository/driver_repository.dart';
import 'package:cloud_bites_driver/app/utils/service/sockets/socket_services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice2/directions.dart' as directions;
import 'package:location/location.dart';

class HomeController extends GetxController {
  final Repository _repository = Repository();

  // For Location Tracking  Code
  final directions.GoogleMapsDirections directionsApi =
      directions.GoogleMapsDirections(
        apiKey: 'AIzaSyDzQVQbsU8deMxfBC-0SPO2ixd8TGaTNBo',
      );
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  Rx<LatLng?> driverLocation = Rx<LatLng?>(null);
  Rx<LatLng?> vendorLocation = Rx<LatLng?>(null);
  Rx<LatLng?> userLocation = Rx<LatLng?>(null);
  Timer? _locationTimer;
  StreamSubscription<LocationData>? locationSubscription;

  final Rx<BitmapDescriptor> driverIcon = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> userIcon = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> vendorIcon = BitmapDescriptor.defaultMarker.obs;
  // End of Location Variable Code

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
  Rx<AcceptedOrderModel?> orderDetails = Rx<AcceptedOrderModel?>(null);

  TextEditingController otpController = TextEditingController();
  var isSlid = false.obs;
  Timer? changeLocationTimer;
  void onSlideCompleted() {
    isSlid.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    locationSubscription?.cancel();
    _initializeServices();
    _initSocketListeners();
    _loadCustomMarker();
    getDriverData();
  }

  @override
  void onClose() {
    locationSubscription?.cancel();
    stopAcceptanceTimer();
    resendTime?.cancel();
    socketService.off('driverOnlineConfirmed');
    socketService.off('driverOfflineConfirmed');
    cleanupResources();
    super.onClose();
  }

  // Initialization Methods
  void _initializeServices() {
    driverRepo.joinDriver();
    _getUserLocation();
    driverIsOnline();
    driverRepo.listenForNewOrders();

    ever(driverRepo.currentOrder, (OrderModel? order) {
      if (order != null) bottomSheetController.showNewOrder(order, "");
    });

    ever(driverRepo.orderDetails, (AcceptedOrderModel? details) {
      if (details != null) {
        bottomSheetController.showAcceptedOrderDetails(details);
      }
    });

    ever(orderDetails, (details) {
      if (details != null) _startLocationTracking();
    });
  }

  void _loadCustomMarker() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      ImageConstants.driver_icon,
    );
    driverIcon.value = icon;
  }

  Future<void> _initLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
  }

  Future<String> getAddressFromLatLong(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String address =
            "${place.street}, ${place.subLocality}, ${place.locality}, "
            "${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        return address;
      } else {
        return "No address available";
      }
    } catch (e) {
      print("Error: $e");
      return "Failed to get address";
    }
  }

  Future<void> _getUserLocation() async {
    try {
      await _initLocationService();
      final locationData = await location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        driverLocation.value = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        initialCameraPosition.value = CameraPosition(
          target: driverLocation.value!,
          zoom: 14.0,
        );

        _startLocationTracking();
      }
    } catch (e) {
      print("Error getting location: $e");
      CustomSnackBar.show(
        message: 'Location services required',
        color: AppTheme.red,
      );
    }
  }

  void _startLocationTracking() {
    locationSubscription?.cancel();
    _locationTimer?.cancel();

    const LocationSettings locationSettings = LocationSettings(
      distanceFilter: 30,
    );

    locationSubscription = location.onLocationChanged.listen(
      (LocationData currentLocation) async {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          final newPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          driverLocation.value = newPosition;
          _updateMapWithNewLocation(newPosition);

          if (_locationTimer == null || !_locationTimer!.isActive) {
            if (orderDetails.value != null &&
                orderDetails.value?.data?.orderDetail?.orderdata?.id != null) {
              _locationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
                _sendLocationUpdate(
                  orderDetails.value!.data!.orderDetail!.orderdata!.id
                      .toString(),
                );
              });
            }
          }
        }
      },
      onError: (e) {
        print("Location error: $e");
        if (e.code == 'PERMISSION_DENIED') {
          CustomSnackBar.show(
            message: 'Location permissions required',
            color: AppTheme.red,
          );
        }
      },
    );
  }

  void _updateMapWithNewLocation(LatLng newLocation) {
    markers.removeWhere((marker) => marker.markerId.value == 'driver');
    markers.add(
      Marker(
        markerId: MarkerId('driver'),
        position: newLocation,
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: driverIcon.value,
        anchor: Offset(0.5, 0.5),
        rotation: _calculateRotation(newLocation),
      ),
    );

    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(newLocation));
    }
    updateMapWithDirections();
  }

  double _calculateRotation(LatLng newLocation) {
    if (driverLocation.value == null) return 0.0;

    final oldLocation = driverLocation.value!;
    final latDiff = newLocation.latitude - oldLocation.latitude;
    final lngDiff = newLocation.longitude - oldLocation.longitude;

    return atan2(lngDiff, latDiff) * 180 / pi;
  }

  void _addVendorMarker(LatLng position) async {
    final vendorIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(34, 34)),
      ImageConstants.locIcon,
    );

    markers.removeWhere((marker) => marker.markerId.value == 'vendor');
    markers.add(
      Marker(
        markerId: MarkerId('vendor'),
        position: position,
        infoWindow: InfoWindow(title: 'Vendor Location'),
        icon: vendorIcon,
        zIndex: 2,
      ),
    );
  }

  void _addUserMarker(LatLng position) async {
    final userIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(34, 34)),
      ImageConstants.userLocIcon,
    );

    markers.removeWhere((marker) => marker.markerId.value == 'user');
    markers.add(
      Marker(
        markerId: MarkerId('user'),
        position: position,
        infoWindow: InfoWindow(title: 'Customer Location'),
        icon: userIcon,
        zIndex: 1,
      ),
    );
  }

  Future<void> updateMapWithDirections() async {
    print('update map direction calling');
    print(driverLocation.value?.longitude ?? 'null');
    try {
      if (driverLocation.value == null) {
        await _getUserLocation();
        if (driverLocation.value == null) {
          throw Exception('Driver location not available');
        }
      }

      // Ensure order details exist
      if (orderDetails.value == null) {
        throw Exception('No order details available');
      }

      final order = orderDetails.value!.data!.orderDetail!;
      final isPickup = orderDetails.value?.data?.pickUp == false;

      // Get destination coordinates with proper null checks
      double? destLat, destLng;
      String? destName;

      if (isPickup) {
        print("$isPickup-----------------");
        destLat = order.vendordata?.latitude;
        destLng = order.vendordata?.longitude;
        destName = 'Vendor';
        print("$destLat $destLng this is $destName lat and longitude");

        if (destLat != null && destLng != null) {
          vendorLocation.value = LatLng(destLat, destLng);
          _addVendorMarker(vendorLocation.value!);
        }
      } else {
        print("$isPickup-----------------");
        destLat = order.userAddressData?.latitude;
        destLng = order.userAddressData?.longitude;
        destName = 'User';
        print("$destLat $destLng this is $destName lat and longitude");

        if (destLat != null && destLng != null) {
          userLocation.value = LatLng(destLat, destLng);
          _addUserMarker(userLocation.value!);
        }
      }

      if (destLat == null || destLng == null) {
        throw Exception('$destName location coordinates not available');
      }

      // Validate coordinates are not 0.0
      if (destLat == 0.0 || destLng == 0.0) {
        throw Exception('Invalid $destName coordinates (0.0, 0.0)');
      }

      print('📍 Origin: ${driverLocation.value}');
      print('🏁 Destination: ($destLat, $destLng)');

      // Draw polyline
      await _addDirectionPolyline(
        origin: driverLocation.value!,
        destination: LatLng(destLat, destLng),
        polylineId: 'active_route',
        color: AppTheme.primaryColor,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addDirectionPolyline({
    required LatLng origin,
    required LatLng destination,
    required String polylineId,
    required Color color,
  }) async {
    try {
      // 1. Validate coordinates
      print('📍 Origin: (${origin.latitude}, ${origin.longitude})');
      print(
        '🏁 Destination: (${destination.latitude}, ${destination.longitude})',
      );

      // 2. Make API call
      final response = await directionsApi
          .directionsWithLocation(
            directions.Location(lat: origin.latitude, lng: origin.longitude),
            directions.Location(
              lat: destination.latitude,
              lng: destination.longitude,
            ),
          )
          .timeout(Duration(seconds: 10)); // Add timeout

      // 3. Handle response
      if (response.status != 'OK') {
        throw Exception('API Error: ${response.errorMessage}');
      }

      if (response.routes.isEmpty) {
        throw Exception('No routes found');
      }

      // 4. Decode polyline
      final points = PolylinePoints().decodePolyline(
        response.routes.first.overviewPolyline.points,
      );

      final polylineCoordinates =
          points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

      // 5. Add to map
      polylines.add(
        Polyline(
          polylineId: PolylineId(polylineId),
          color: color,
          points: polylineCoordinates,
          width: 5,
          visible: true,
        ),
      );

      print('✅ Route calculated with ${polylineCoordinates.length} points');
    } catch (e) {
      print('❌ Route calculation failed: $e');
      CustomSnackBar.show(
        message:
            'Could not calculate route: ${e.toString().replaceAll('Exception: ', '')}',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      rethrow;
    }
  }

  void _updateCameraPosition() {
    if (mapController == null || driverLocation.value == null) return;

    final points = <LatLng>[driverLocation.value!];
    if (vendorLocation.value != null) points.add(vendorLocation.value!);
    if (userLocation.value != null) points.add(userLocation.value!);

    if (points.length < 2) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(driverLocation.value!, 16),
      );
      return;
    }
    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(_boundsFromLatLngList(points), 100),
    );
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        x1 = x1! > latLng.latitude ? x1 : latLng.latitude;
        x0 = x0 < latLng.latitude ? x0 : latLng.latitude;
        y1 = y1! > latLng.longitude ? y1 : latLng.longitude;
        y0 = y0! < latLng.longitude ? y0 : latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  void _addMarkers() {
    markers.clear();

    // Driver Marker
    if (driverLocation.value != null) {
      markers.add(
        Marker(
          markerId: MarkerId('driver'),
          position: driverLocation.value!,
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: driverIcon.value,
          zIndex: 3,
        ),
      );
    }

    // Vendor Marker for PickUp
    if (vendorLocation.value != null) {
      print("${vendorLocation.value} value of driver location");
      markers.add(
        Marker(
          markerId: MarkerId('vendor'),
          position: vendorLocation.value!,
          infoWindow: InfoWindow(title: 'Vendor Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          zIndex: 2,
        ),
      );
    }

    // User Marker for Deliver
    if (userLocation.value != null) {
      markers.add(
        Marker(
          markerId: MarkerId('user'),
          position: userLocation.value!,
          infoWindow: InfoWindow(title: 'Customer Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          zIndex: 1,
        ),
      );
    }
  }

  void clearMapAfterDelivery() {
    // 1. Cancel all timers and subscriptions
    _locationTimer?.cancel();
    locationSubscription?.cancel();

    // 2. Clear all map elements
    polylines.clear();
    markers.clear();

    // 3. Reset all location variables
    vendorLocation.value = null;
    userLocation.value = null;

    // 4. Reset order details
    orderDetails.value = null;

    // 5. Reset the map view
    if (mapController != null && driverLocation.value != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(driverLocation.value!, 14),
      );
    }

    print('🗺️ Map fully cleared after delivery completion');
  }

  // For Remaining Time
   RxInt remainingTime = 30.obs;
   int totalTime = 30;
  Timer? acceptanceTimer;

  /*void startTimer() {
     remainingTime.value = totalTime;
     acceptanceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        stopAcceptanceTimer();
        final order = bottomSheetController.currentOrder.value;
        if (order != null) {
          timeoutOrder(order.orderId.toString());
        }
        bottomSheetController.timeoutOrder();
      }
    });
  }*/

  void startTimer() {
    if (bottomSheetController.currentSheet.value ==
            BottomSheetState.newOrderArrived &&
        (acceptanceTimer == null || !acceptanceTimer!.isActive)) {
      remainingTime.value = totalTime;
      acceptanceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (bottomSheetController.currentSheet.value !=
            BottomSheetState.newOrderArrived) {
          stopAcceptanceTimer();
          return;
        }
        if (remainingTime.value > 0) {
          remainingTime.value--;
        } else {
          stopAcceptanceTimer();
          if (bottomSheetController.currentSheet.value ==
              BottomSheetState.newOrderArrived) {
            bottomSheetController.currentSheet.value = BottomSheetState.none;
            bottomSheetController.showLookingForOrders();
            final order = bottomSheetController.currentOrder.value;
            if (order != null) {
              print(
                "About to call timeoutOrder with orderId: ${order.orderId}",
              );
              timeoutOrder(order.orderId.toString());
            }
            // bottomSheetController.timeoutOrder();
          }
        }
      });
    }
  }

  void stopAcceptanceTimer() {
    print('stopAcceptanceTimer CALLED-----dddddddddddddddddddddd');
    acceptanceTimer?.cancel();
    acceptanceTimer = null;
  }

  void resetAcceptanceTimer() {
    stopAcceptanceTimer();
    remainingTime.value = totalTime;
  }

  final BottomSheetController bottomSheetController = Get.put(
    BottomSheetController(),
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // for otp event----
  final RxString otpPhoneNumber = ''.obs;
  final RxString otpCode = ''.obs;

  void sendOtp() {
    orderDetails.value = bottomSheetController.orderDetails.value;
    bottomSheetController.showSendOtpSheet();
  }

  void getCurrentOrderDetailsEvent() {
    final driverId = storageServices.getDriverID();
    print("getCurrentOderDetails----------$driverId");
    socketService.sendMessage(SocketEvents.getCurrentOrderDetails, {
      "driverId": driverId,
    });
    print("get currnt order details------------this is event");
    socketService.listenToEvent(SocketEvents.getCurrentOrderDetails, (p0) {
      print("get current order detail------------- $p0");
      if (p0['status'] == true) {
        print("Condition is true=======for getCurrentOrderDetails");
        bottomSheetController.showAcceptedOrderDetails(
          orderDetails.value ?? AcceptedOrderModel(),
        );
      }
    });
  }

  void driverIsOnline() {
    final driverId = storageServices.getDriverID();
    socketService.sendMessage(SocketEvents.isOnline, {"driverId": driverId});
    socketService.listenToEvent(SocketEvents.isOnline, (p0) {
      print("Driver isOnline---------$p0");
      if (p0['status'] == true) {
        if (p0["is_online"] == true) {
          isOnline.value = true;
          getCurrentOrderDetailsEvent();
          _getUserLocation();
          bottomSheetController.showLookingForOrders();
        }
      }
    });
  }

  Future<void> timeoutOrder(String orderId) async {
    try {
      socketService.listenToEvent(SocketEvents.orderNotAccepted, (p0) {
        print("Order Not Accepted Event Received: $p0");
        if (p0['status'] == true) {
          bottomSheetController.hideAllSheets();
          CustomSnackBar.show(
            message: 'Order timed out',
            color: AppTheme.redText,
            tColor: AppTheme.white,
          );
        } else {
          print("Order Not Accepted Event Failed: ${p0['message']}");
        }
      });
      print('Order $orderId Timed Out - Not Accepted');
    } catch (e) {
      print('Failed to timeout order: $e');
      rethrow;
    }
  }

  Future<void> acceptOrder(String orderId) async {
    try {
      stopAcceptanceTimer();
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.acceptOrder, {
        'driverId': driverId,
        'orderId': orderId,
      });
      print('Order $orderId Accepted');
    } catch (e) {
      print('Failed to accept order: $e');
      CustomSnackBar.show(
        message: 'Failed to accept order',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      rethrow;
    }
  }

  Future<void> rejectOrder(String orderId) async {
    try {
      stopAcceptanceTimer();
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.rejectOrder, {
        'driverId': driverId,
        'orderId': orderId,
      });
      print('Order $orderId Rejected');
    } catch (e) {
      print('Failed to accept order: $e');
      CustomSnackBar.show(
        message: 'Failed to accept order',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      rethrow;
    }
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
        'otp': otpController.text,
      });

      socketService.listenToEvent(SocketEvents.sendOTP, (data) {
        print("otp ----------${otpController.text}");
        socketService.off(SocketEvents.sendOTP);
        if (data['status']) {
          otpController.clear();
          if (data["isCompleted"] == true) {
            deliveryComplete();
          } else {
            bottomSheetController.showOrderPickedUp();
          }
        } else {
          print("data $data");
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

  void deliveryComplete() {
    socketService.listenToEvent(SocketEvents.deliveryComplete, (data) {
      socketService.off(SocketEvents.deliveryComplete);
      bottomSheetController.currentOrder.value = null;
      bottomSheetController.orderDetails.value = null;
      print('$data==========After Delivery Complete');
      isSlid.value = false;
      bottomSheetController.showOrderDelivered();
    });
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
    resendTime?.cancel();

    resendEnabled.value = false;
    remainingTimer.value = 60;

    resendTime = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTimer.value > 0) {
        remainingTimer.value--;
      } else {
        resendEnabled.value = true;
        resendTime?.cancel();
      }
    });
  }

  // Socket Code

  void _initSocketListeners() {
    socketService.listenToEvent(SocketEvents.goOnline, (data) {
      isOnline.value = true;
      print('✅ Received driverOnlineConfirmed, showing bottom sheet$data');
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
    });

    socketService.listenToEvent(SocketEvents.acceptedOrderScreen, (data) {
      print('✅ acceptedOrderScreen99000000 $data');
      WidgetDesigns.consoleLog(" $data", "jjjjjjjjjjjjjjjjjjjjjjData");
      try {
        orderDetails.value = AcceptedOrderModel.fromJson(data);
        bottomSheetController.orderDetails.value = orderDetails.value;
        bottomSheetController.orderDetails.refresh();
        if (orderDetails.value?.data?.orderDetail?.vendordata?.latitude !=
                null &&
            orderDetails.value?.data?.orderDetail?.vendordata?.longitude !=
                null) {
          driverLocation.value = LatLng(
            orderDetails.value?.data?.orderDetail?.vendordata?.latitude ?? 0,
            orderDetails.value?.data?.orderDetail?.vendordata?.longitude ?? 0,
          );
        }
        updateMapWithDirections();
        if (orderDetails.value?.data?.pickUp == false) {
          print("55");
          bottomSheetController.showAcceptedOrderDetails(orderDetails.value!);
        } else {
          print("56");
          final orderModel = OrderModel(
            // remainingSec: ,
            expiryTime: "",
            orderId: orderDetails.value?.data?.orderDetail?.orderdata?.id ?? "",
            remainingSec: "30",
            vendorId:
                orderDetails.value?.data?.orderDetail?.vendordata?.id ?? "",
            orderNumber:
                orderDetails.value?.data?.orderDetail?.orderdata?.orderId ?? "",
            quantity:
                orderDetails.value?.data?.orderDetail?.orderdata?.quantity ??
                "",
            totalAmount:
                orderDetails.value?.data?.orderDetail?.orderdata?.totalAmount ??
                "",
            deliveryTime:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.orderdata
                    ?.deliveryTime ??
                '',
            restaurantName:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.vendordata
                    ?.restaurantName ??
                "",
            vendorAddress:
                orderDetails.value?.data?.orderDetail?.vendordata?.address ??
                "",
            vendorLatitude:
                orderDetails.value?.data?.orderDetail?.vendordata?.latitude ??
                0.0,
            vendorLongitude:
                orderDetails.value?.data?.orderDetail?.vendordata?.longitude ??
                0.0,
            userAddress:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.userAddressData
                    ?.completeAddress ??
                "",
            userLatitude:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.userAddressData
                    ?.latitude ??
                0.0,
            userLongitude:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.userAddressData
                    ?.longitude ??
                0.0,
            pickupDistance:
                orderDetails.value?.data?.pickUpLocation?.distance ?? "",
            pickupDuration:
                orderDetails.value?.data?.pickUpLocation?.duration ?? "",
            deliveryDistance:
                orderDetails.value?.data?.deliveryLocation?.distance ?? "",
            deliveryCharge:
                orderDetails
                    .value
                    ?.data
                    ?.orderDetail
                    ?.orderdata
                    ?.deliveryCharge ??
                "",
            deliveryDuration:
                orderDetails.value?.data?.deliveryLocation?.duration ?? "",
          );
          bottomSheetController.showNewOrder(orderModel, "accepted order");
        }
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

    changeLocationTimer = Timer.periodic(Duration(minutes: 1), (Timer t) async {
      if (bottomSheetController.orderDetails.value == null &&
          bottomSheetController.currentOrder.value == null &&
          isOnline.value == true) {
        var address = await getAddressFromLatLong(
          driverLocation.value?.latitude ?? 0.0,
          driverLocation.value?.longitude ?? 0.0,
        );
        socketService.sendMessage(SocketEvents.changeDriverLocation, {
          "driverId": storageServices.getDriverID(),
          "latitude": driverLocation.value?.latitude ?? 0.0,
          "longitude": driverLocation.value?.longitude ?? 0.0,
          "address": address,
        });
      } else {
        print("driver busy===================");
      }
    });

    // driverRepo.listenForNewOrders();
  }

  void readyForDeliveryEvent() {
    final driverId = storageServices.getDriverID();
    final orderDetails = bottomSheetController.orderDetails.value;
    socketService.sendMessage(SocketEvents.readyForDelivery, {
      "orderId": orderDetails?.data?.orderDetail?.orderdata?.id ?? '',
      "driverId": driverId,
    });
    bottomSheetController.afterReadyForDeliveryBuild();
    socketService.listenToEvent("readyForDelivery", (p0) {
      print("object");
    });
  }
var isOnlineLoading = false.obs;
  Future<void> toggleOnlineStatus() async {
    isOnlineLoading.value = true;
    try {
      if (isOnline.value) {
        // Emit offline request
         driverRepo.goOffline();
        // UI will update when socket confirms via `driverOfflineConfirmed`
      } else {
        final currentLocation = await location.getLocation();
        final address  = await getAddressFromLatLong(
          currentLocation.latitude ?? 0.0,
          currentLocation.longitude ?? 0.0,
        );
         driverRepo.goOnline(
          firstName: storageServices.getFirstName(),
          lastName: storageServices.getLastName(),
          fcmToken: storageServices.returnFCMToken(),
          latitude: currentLocation.latitude!,
          longitude: currentLocation.longitude!,
          address: address,
          vehicle_type: storageServices.getDeliveryType(),
        );
        // driverRepo.listenForNewOrders();
      }
    } catch (e) {
      print(e);
    }finally{
      isOnlineLoading.value = false;
    }
  }

  void joinDriverEvent() {
    try {
       driverRepo.joinDriver();
      print('-------Driver Joined--------');
    } catch (e) {
      print(e);
    }
  }

  void _sendLocationUpdate(String orderId) {
    if (driverLocation.value == null) return;
    print('📡 Sending location update at ${DateTime.now()}');
    print(
      '📍 Location: ${driverLocation.value!.latitude}, ${driverLocation.value!.longitude}',
    );
    try {
      print("track driver location in try block===========$orderId");
      socketService.sendMessage(SocketEvents.trackDriverLocation, {
        "driverId": storageServices.getDriverID(),
        "orderId": orderId,
        "latitude": driverLocation.value!.latitude,
        "longitude": driverLocation.value!.longitude,
        "address":
            orderDetails
                .value
                ?.data
                ?.orderDetail
                ?.userAddressData
                ?.completeAddress,
        "userId":
            orderDetails.value?.data?.orderDetail?.userdata?.id?.toString(),
      });
    } catch (e) {
      print("====$e=========newwwwwwwww");
    }
  }

  Rx<ApiResponse<GetDriverDataModel>> driverData =
      Rx<ApiResponse<GetDriverDataModel>>(ApiResponse.loading());
  setDriverData(ApiResponse<GetDriverDataModel> value) {
    driverData.value = value;
  }

  getDriverData() async {
    setDriverData(ApiResponse.loading());
    try {
      final apiData = await _repository.getDriverDataAPI();
      if (apiData.status == true) {
        WidgetDesigns.consoleLog("Driver Data get", "get driver data");
        setDriverData(ApiResponse.completed(apiData));
      } else {
        WidgetDesigns.consoleLog(
          apiData.message?.toString() ?? "Error while get driver data",
          "error while get driver data",
        );
        CustomSnackBar.show(
          message: apiData.message?.toString() ?? "Error while get driver data",
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
        setDriverData(
          ApiResponse.error(
            apiData.message?.toString() ?? "Error while get driver data",
          ),
        );
      }
    } catch (e) {
      setDriverData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get driver data");
      CustomSnackBar.show(
        message: e.toString(),
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
    }
  }


  // Add this method to your HomeController class
  void cleanupResources() {
    print('🧹 Cleaning up HomeController resources...');

    // 1. Cancel all timers
    _locationTimer?.cancel();
    _locationTimer = null;

    changeLocationTimer?.cancel();
    changeLocationTimer = null;

    acceptanceTimer?.cancel();
    acceptanceTimer = null;

    resendTime?.cancel();
    resendTime = null;

    // 2. Cancel location subscription
    locationSubscription?.cancel();
    locationSubscription = null;

    // 3. Clear map resources
    clearMapAfterDelivery();

    // 4. Remove all socket listeners
    socketService.off('driverOnlineConfirmed');
    socketService.off('driverOfflineConfirmed');
    socketService.off(SocketEvents.joinDriver);
    socketService.off(SocketEvents.acceptedOrderScreen);
    socketService.off(SocketEvents.otpPhoneNo);
    socketService.off(SocketEvents.newOrder);
    socketService.off(SocketEvents.orderNotAccepted);
    socketService.off(SocketEvents.acceptOrder);
    socketService.off(SocketEvents.rejectOrder);
    socketService.off(SocketEvents.sendOTP);
    socketService.off(SocketEvents.deliveryComplete);
    socketService.off(SocketEvents.getCurrentOrderDetails);
    socketService.off(SocketEvents.isOnline);
    socketService.off(SocketEvents.readyForDelivery);
    socketService.off(SocketEvents.trackDriverLocation);

    // 5. Reset all state variables
    isOnline.value = false;
    orderDetails.value = null;
    driverLocation.value = null;
    vendorLocation.value = null;
    userLocation.value = null;

    // 6. Clear markers and polylines
    markers.clear();
    polylines.clear();

    // 7. Dispose of map controller if exists
    mapController?.dispose();
    mapController = null;

    print('✅ HomeController resources cleaned up successfully');
  }

}
