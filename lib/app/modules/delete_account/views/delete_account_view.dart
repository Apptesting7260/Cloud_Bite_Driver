import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/AppImages.dart';
import '../../../utils/custom_widgets/MyText.dart';
import '../controllers/delete_account_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DeleteAccountController>(
        init: DeleteAccountController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Image.asset(AppImages.backIconImage),
                onPressed: () {
                  Get.back();
                },
              ),
              title: MyText(
                title: 'Delete Account',
                fSize: 22,
                tColor: Colors.black,
              ),
            ),
            body: WebViewWidget(controller: controller.webViewController),
          );
        },
      ),
    );
  }
}
