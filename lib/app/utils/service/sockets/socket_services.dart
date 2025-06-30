import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  late IO.Socket socket;
  final RxBool isConnected = false.obs;
  final RxBool isConnecting = false.obs;
  final RxInt reconnectAttempts = 0.obs;
  final int maxReconnectAttempts = 5;

  Future<SocketService> init() async {
    await _connectSocket();
    return this;
  }

  Future<void> _connectSocket() async {
    if (isConnecting.value || isConnected.value) return;

    isConnecting.value = true;
    reconnectAttempts.value = 0;

    socket = IO.io(
      AppUrls.socketURl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(maxReconnectAttempts)
          .setReconnectionDelay(1000)
          .setTimeout(5000)
          .build(),
    );

    // Connection established
    socket.onConnect((_) {
      isConnected.value = true;
      isConnecting.value = false;
      reconnectAttempts.value = 0;
      print('🔌 Socket connected');
      /*emitEvent('joinDriver', {
        'driverId': 460
      });*/
    });

    // Disconnected
    socket.onDisconnect((_) {
      isConnected.value = false;
      print('❌ Socket disconnected');
      _attemptReconnect();
    });

    // Connection error
    socket.onConnectError((data) {
      isConnecting.value = false;
      print('🚨 Socket connect error: $data');
      _attemptReconnect();
    });

    // General error
    socket.onError((data) {
      print('📩 Socket error: $data');
    });

    // Reconnect attempt
    socket.onReconnectAttempt((attempt) {
      reconnectAttempts.value = attempt;
      print('🔄 Reconnect attempt $attempt/$maxReconnectAttempts');
    });

    // Reconnect failed
    socket.onReconnectFailed((_) {
      isConnecting.value = false;
      print('❌ Reconnect failed after $maxReconnectAttempts attempts');
    });
  }

  void _attemptReconnect() {
    if (reconnectAttempts.value < maxReconnectAttempts) {
      Future.delayed(Duration(seconds: 2), _connectSocket);
    }
  }

  Future<void> emitEvent(String eventName, dynamic data) async {
    if (!isConnected.value) {
      print('⚠️ Socket not connected, attempting to connect...');
      await _connectSocket();

      // Wait for connection with timeout
      try {
        await Future.any([
          isConnected.stream.firstWhere((connected) => connected),
          Future.delayed(Duration(seconds: 5),
                  () => throw TimeoutException('Connection timeout'))
        ]);
      } catch (e) {
        print('❌ Failed to connect: $e');
        throw Exception('Failed to establish socket connection');
      }
    }

    if (isConnected.value) {
      print('📤 Emitting $eventName: $data');
      socket.emit(eventName, data);
    } else {
      print('❌ Failed to connect, cannot emit $eventName');
      throw Exception('Socket not connected');
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.clearListeners();
    super.onClose();
  }
}