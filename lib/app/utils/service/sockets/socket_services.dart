import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService{
  late IO.Socket socket;
  final RxBool isConnected = false.obs;

  Future<SocketService> init() async {
    socket = IO.io(
      AppUrls.baseUrl,
      IO.OptionBuilder()
        .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
    socket.onConnect((_) {
      isConnected.value = true;
      print('🔌 Socket connected');
    });

    socket.onDisconnect((_) {
      isConnected.value = false;
      print('❌ Socket disconnected');
    });

    socket.onError((data) {
      print('📩 Socket error: $data');
    });

    return this;
  }

  void emitEvent(String eventName, dynamic data) {
    if (isConnected.value) {
      socket.emit(eventName, data);
    } else {
      print('Socket not connected, cannot emit $eventName');
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}