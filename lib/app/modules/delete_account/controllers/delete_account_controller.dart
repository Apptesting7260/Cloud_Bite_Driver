import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/MyUrl.dart';

class DeleteAccountController extends GetxController {
  //TODO: Implement DeleteAccountController

  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(NavigationDelegate())
          ..loadRequest(
            Uri.parse("${MyUrl.baseUrl}api/v2/delete/delete-account?type=user"),
          );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
