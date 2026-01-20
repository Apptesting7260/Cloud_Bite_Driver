import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/app_urls.dart';


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
            Uri.parse("${AppUrls.baseUrl}/api/v2/delete/delete-account?type=driver"),
          );
  }


  @override
  void onClose() {}
}
