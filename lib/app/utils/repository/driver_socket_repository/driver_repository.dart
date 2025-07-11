import 'package:cloud_bites_driver/app/constants/socket_url.dart';
import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/accepted_order_model.dart';
import 'package:cloud_bites_driver/app/modules/delivery_process/model/otp_verification_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverRepository {
  var socketService = Get.find<SocketController>();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final RxBool isOtpVerified = false.obs;

  /*DriverRepository() {
    listenForNewOrders();
    listenForOrderDetails();
  }*/

  // 1. GO Online Event
  Future<void> goOnline({
    required String firstName,
    required String lastName,
    required String fcmToken,
    required double latitude,
    required double longitude,
    required String address,
    required String vehicle_type
  }) async {
    try {
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.goOnline, {
        'driverId': driverId,
        'firstName': firstName,
        'lastName': lastName,
        'fcmToken': fcmToken,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'vehicle_type': storageServices.getDeliveryType()
      });
    } catch (e) {
      print('Failed to go online: $e');
      CustomSnackBar.show(
        message: 'Failed to connect to server',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      rethrow;
    }
  }

  // 2. Go Offline Event
  Future<void> goOffline() async {
    try {
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.goOffline, {
        'driverId': driverId,
      });
    } catch (e) {
      print('Failed to go offline: $e');
      CustomSnackBar.show(
        message: 'Failed to disconnect from server',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
      rethrow;
    }
  }

  // 3. Join Driver Event
  Future<void> joinDriver() async {
    try{
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.joinDriver, {
        'driverId': driverId
      });
      print('========Joined Driver========');
    } catch(e){
      print('Failed to join: $e');
      CustomSnackBar.show(
        message: 'Failed to disconnect from server',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
    }
  }

  // 4. New Order Coming Event
  final Rx<OrderModel?> currentOrder = Rx<OrderModel?>(null);

  void listenForNewOrders() {
    print('Listening for newOrder events'); // Confirm listener is set up
  }


  // 5 New Order not accepted (when driver not clicked any option accept and reject)
 /* Future<void> timeoutOrder(String orderId) async {
    try {
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.orderNotAccepted, {
        'driverId': driverId,
        'orderId': orderId,
      });
      print('Order $orderId Timed Out - Not Accepted');
    } catch (e) {
      print('Failed to timeout order: $e');
      rethrow;
    }
  }*/

  // 6 Accept Order Event
 /* Future<void> acceptOrder(String orderId) async {
    try {
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.acceptOrder, {
        'driverId': driverId,
        'orderId': orderId,
      });
      updateMapWithDirections();
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
  }*/

  // 7 Accepted Order Event
  final Rx<AcceptedOrderModel?> orderDetails = Rx<AcceptedOrderModel?>(null);

  void listenForOrderDetails() {
    socketService.listenToEvent(SocketEvents.acceptedOrderScreen, (data) {
      try {
        print('Raw acceptedOrderScreen data: $data');
        if (data is Map<String, dynamic>) {
          orderDetails.value = AcceptedOrderModel.fromJson(data);
          print('Order details received for order: ${orderDetails.value?.data?.orderDetail?.orderdata?.orderId}');
        } else {
          print('Invalid order details format - Expected Map but got ${data.runtimeType}');
        }
      } catch (e, stackTrace) {
        print('Error parsing order details: $e');
        print('Stack trace: $stackTrace');
      }
    });
  }

  // 8 Reject Order Event
  /*Future<void> rejectOrder(String orderId) async {
    try {
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
  }*/

  // 9 Send OTP Emit Event
  Future<void> sendOTP(String orderId) async {
    try {
      final driverId = storageServices.getDriverID();
       socketService.sendMessage(SocketEvents.sendOTP, {
        'driverid': driverId,
        'orderId': orderId,
        'action': 'generate'
      });
    } catch (e) {
      print('Failed to send OTP: $e');
      rethrow;
    }
  }

  // 10 Verify Phone Number Event
  Future<void> verifyPhoneEvent(String orderId, String otp) async {
    try {
      final driverId = storageServices.getDriverID();
       socketService.sendMessage(SocketEvents.sendOTP, {
        'driverid': driverId,
        'orderId': orderId,
        'action': 'verify',
        'otp': otp
      });
    } catch (e) {
      print('Failed to send OTP: $e');
      rethrow;
    }
  }


  void updateLocation({
    required double latitude,
    required double longitude,
    required String address,
  })  {
    try {
      final driverId = storageServices.getDriverID();
       socketService.sendMessage('updateLocation', {
        'driverId': driverId,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      });
    } catch (e) {
      print('Failed to update location: $e');
    }
  }
}