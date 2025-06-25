import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DriverRepository {
  final SocketService _socketService = Get.find<SocketService>();

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  // 1. GO Online Event
  void goOnline({
    required String firstName,
    required String lastName,
    required String fcmToken,
    required double latitude,
    required double longitude,
    required String address
  }){
    final driverId = storageServices.getDriverID();
    _socketService.emitEvent('goOnline', {
      'driverId': driverId,
      'firstName': firstName,
      "lastName": lastName,
      'fcmToken': fcmToken,
      'latitude': latitude,
      'longitude': longitude,
      'address': address
    });
}

  // 2. Go Offline Event
  void goOffline(){
    final driverId = storageServices.getDriverID();
    _socketService.emitEvent('goOffline', {
      'driverId': driverId
    });
  }

  // 3. Update Location Event
  void updateLocation({
    required double latitude,
    required double longitude,
    required String address
  }){
    final driverId = storageServices.getDriverID();
    _socketService.emitEvent('',{
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
  }
}