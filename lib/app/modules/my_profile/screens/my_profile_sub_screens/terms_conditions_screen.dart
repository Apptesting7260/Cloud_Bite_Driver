import 'package:cloud_bites_driver/app/core/app_exports.dart';

class TermsCondtion extends StatelessWidget{

  final TermsConditionController controller = Get.put(TermsConditionController());


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
        if (controller.termsUrl.value.isNotEmpty) {
          return TermsConditionWebView(url: controller.termsUrl.value);
        }
        return Center(child: Text('No terms & conditions available'));
      }),
    );
  }
}