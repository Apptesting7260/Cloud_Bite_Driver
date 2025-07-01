import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DriverRepository {
  final SocketService _socketService = Get.find<SocketService>();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  // 1. GO Online Event
  Future<void> goOnline({
    required String firstName,
    required String lastName,
    required String fcmToken,
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    try {
      final driverId = storageServices.getDriverID();
      await _socketService.emitEvent('goOnline', {
        'driverId': driverId,
        'firstName': firstName,
        'lastName': lastName,
        'fcmToken': fcmToken,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
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
      await _socketService.emitEvent('goOffline', {
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
      await _socketService.emitEvent('joinDriver', {
        'driverId': driverId
      });
      print('Joined Driver');
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
    _socketService.socket.on('newOrder', (data) {
      try {
        print('Raw newOrder data: $data');
        if (data is Map<String, dynamic>) {
          currentOrder.value = OrderModel.fromJson(data);
          print('New order received: ${currentOrder.value?.orderNumber}');
        } else {
          print('Invalid order data format - Expected Map but got ${data.runtimeType}');
        }
      } catch (e, stackTrace) {
        print('Error parsing new order: $e');
        print('Stack trace: $stackTrace');
      }
    });
    print('Listening for newOrder events'); // Confirm listener is set up
  }


  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    try {
      final driverId = storageServices.getDriverID();
      await _socketService.emitEvent('updateLocation', {
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