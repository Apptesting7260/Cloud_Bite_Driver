import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io(
      AppUrls.socketURl,
      IO.OptionBuilder()
          .enableAutoConnect()
          .setTransports(['websocket'])
          .enableReconnection()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print(socket.id);
      if(Get.isRegistered<HomeController>()){
        var homeController = Get.find<HomeController>();
      }
      print('🔌 Socket connected');
    });

    socket.onDisconnect((_) {
      print('❌ Socket disconnected');
    });

    // Example event listener
    socket.on('message', (data) {
      print('📩 New message: $data');
    });
  }

  void sendMessage(String event, dynamic message) {
    socket.emit(event, message);
  }

  /*socket = IO.io(  serverUrl,  IO.OptionBuilder()      .setTransports(['websocket'])      .enableAutoConnect()      .build(),);*/

  void listenToEvent(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void off(String event) {
    socket.off(event);
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }
}