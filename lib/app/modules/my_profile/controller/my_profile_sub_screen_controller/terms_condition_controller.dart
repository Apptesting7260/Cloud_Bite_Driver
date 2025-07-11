import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/repository/repository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TermsConditionController extends GetxController {
  final Repository _repository = Repository();
  var termsUrl = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTermsCondition();
    super.onInit();
  }

  Future<void> fetchTermsCondition() async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await _repository.termsConditionApi();
      termsUrl.value = response.url ?? '';
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}