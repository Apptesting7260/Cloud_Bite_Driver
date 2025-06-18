import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  final RxBool isConnected = true.obs;

  Future<NetworkService> init() async {
    // Check initial connectivity (returns single result)
    try {
      final  result = await _connectivity.checkConnectivity();
      _updateInitialConnectionStatus(result[0]);
    } catch (_) {
      isConnected.value = false;
    }

    // Listen to ongoing changes (returns list)
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    return this;
  }

  void _updateInitialConnectionStatus(ConnectivityResult result) {
    final hasConnection = result != ConnectivityResult.none;
    isConnected.value = hasConnection;

    if (!hasConnection && Get.currentRoute != '/no-internet-connection') {
      Get.toNamed('/no-internet-connection');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((result) => result != ConnectivityResult.none);
    isConnected.value = hasConnection;

    if (!hasConnection) {
      if (Get.currentRoute != '/no-internet-connection') {
        Get.toNamed('/no-internet-connection');
      }
    } else {
      if (Get.currentRoute == '/no-internet-connection') {
        Get.back(); // Return to previous page
      }
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
