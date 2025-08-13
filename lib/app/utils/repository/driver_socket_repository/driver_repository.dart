import 'package:cloud_bites_driver/app/constants/socket_url.dart';
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DriverRepository {
  var socketService = Get.find<SocketController>();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final RxBool isOtpVerified = false.obs;

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
    print("lonline wala");
    try {
      print("online he h");
      final driverId = storageServices.getDriverID();
      socketService.sendMessage(SocketEvents.goOnline, {
        'driverId': driverId,
        'firstName': firstName,
        'lastName': lastName,
        'fcmToken': fcmToken,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'vehicle_type': vehicle_type,
      });
    } catch (e) {
      print('Failed to go online: $e');
      CustomSnackBar.show(
        message: 'Failed to connect to server',
        color: AppTheme.redText,
        tColor: AppTheme.white,
      );
    }
  }

  // 2. Go Offline Event
  Future<void> goOffline() async {
    print("offlineeeeeeeeeeeeeeeee");
    try {
      print("workkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      final driverId = storageServices.getDriverID();
      print("DriverId for Go Offline event-----------");
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
      print("DriverId for join driver event-----------");
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
    print('Listening for newOrder events');
  }


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