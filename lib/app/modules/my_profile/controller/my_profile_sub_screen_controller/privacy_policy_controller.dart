import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/repository/repository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PrivacyPolicyController extends GetxController {
  final Repository _repository = Repository();
  var policyUrl = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPrivacyPolicy();
    super.onInit();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await _repository.privacyPolicyApi();
      policyUrl.value = response.url ?? '';
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}