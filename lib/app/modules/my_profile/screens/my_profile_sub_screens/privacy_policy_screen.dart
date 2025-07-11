import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PrivacyPolicyScreen extends StatelessWidget{

  final PrivacyPolicyController controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (controller.policyUrl.value.isNotEmpty) {
          return PrivacyPolicyWebView(url: controller.policyUrl.value);
        }
        return Center(child: Text('No privacy policy available'));
      }),
    );
  }
}