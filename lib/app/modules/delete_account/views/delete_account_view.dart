import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/image_constants.dart';
import '../../../utils/custom_widgets/my_text.dart';
import '../controllers/delete_account_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({super.key});

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
                icon: Image.asset(ImageConstants.backIconImage),
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
